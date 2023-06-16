//
//  SplashViewModel.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 31/5/23.
//

import Foundation

import RxCocoa
import RxSwift

struct SplashViewModel: ISplashViewModel {

    let localStorageUseCase: ILocalStorageUseCase
    let _onCompleted = PublishRelay<SplashFlow.Result>()

    var onCompleted: Infallible<SplashFlow.Result> {
        self._onCompleted.asInfallible()
    }

    func transform(viewDidAppear: Signal<Void>) -> Completable {
        return viewDidAppear
            .map { .completed(isSignedIn: self.localStorageUseCase.accessToken != nil) }
            .do(onNext: self._onCompleted.accept)
            .asObservable()
            .ignoreElements()
            .asCompletable()
    }
}
