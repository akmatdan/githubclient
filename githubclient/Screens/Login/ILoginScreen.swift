//
//  ILoginScreen.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 31/5/23.
//

import Foundation

import Resolver
import RxCocoa
import RxSwift

protocol ILoginScreen: AnyObject {

    var viewModel: ILoginViewModel! { get set }
    var authorizationURL: URL { get }
}

struct LoginScreenOutput {
    let userCode: Driver<String>
    let verificationUri: Driver<URL>
    let logic: Completable
}

protocol ILoginViewModel {

    var onCompleted: Infallible<Void> { get }
    var authorizationURL: URL { get }

    func transform(viewDidAppear: Signal<Void>) -> LoginScreenOutput
}

extension Resolver {

    static func registerLoginScreen() {
        register(ILoginViewModel.self) {
            LoginViewModel(localStorageUseCase: resolve(),
                           githubLoginUseCase: resolve())
        }
        register(ILoginScreen.self) { LoginViewController() }
            .resolveProperties { $1.viewModel = self.optional() }
    }
}
