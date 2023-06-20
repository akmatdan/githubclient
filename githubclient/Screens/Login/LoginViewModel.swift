//
//  LoginViewModel.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 31/5/23.
//

import Foundation

import RxCocoa
import RxSwift

struct LoginViewModel: ILoginViewModel {

    let localStorageUseCase: ILocalStorageUseCase
    let githubLoginUseCase: IGithubLoginUseCase

    let _onCompleted = PublishRelay<Void>()

    var onCompleted: Infallible<Void> {
        self._onCompleted.asInfallible()
    }
    
    var authorizationURL: URL {
            return URL(string: "https://github.com/login/device")!
        }
    
    func transform(viewDidAppear: Signal<Void>) -> LoginScreenOutput {

        let deviceCode = viewDidAppear
            .flatMapLatest {
                self.githubLoginUseCase.deviceCode(clientId: "CLIENT_ID", scopes: ["user"])
                    .asDriver { error in
                        print(error)
                        return .never()
                    }
            }

        let pollingLogic = deviceCode
            .asObservable()
            .flatMapLatest { deviceCode in
                Observable<Int>
                    .timer(.seconds(deviceCode.interval),
                           period: .seconds(deviceCode.interval),
                           scheduler: MainScheduler.instance)
                    .flatMapLatest { _ in
                        self.githubLoginUseCase
                            .oauthAccessToken(
                                clientId: "CLIENT_ID",
                                deviceCode: deviceCode.deviceCode,
                                grantType: "urn:ietf:params:oauth:grant-type:device_code")
                            .catch { error in
                                print(error)
                                return .never()
                            }
                    }
                    .do(onNext: {
                        self.localStorageUseCase.accessToken = $0
                        self._onCompleted.accept(())
                    })
                    .take(until: self._onCompleted)
            }
            .ignoreElements()
            .asCompletable()

        return LoginScreenOutput(
            userCode: deviceCode.map { $0.userCode },
            verificationUri: deviceCode.map { $0.verificationUri },
            logic: pollingLogic)
    }
}
