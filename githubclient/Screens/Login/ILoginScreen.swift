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
}

struct LoginScreenOutput {
    let userCode: Driver<String>
    let verificationUri: Driver<URL>
    let logic: Completable
}

protocol ILoginViewModel {

    var onCompleted: Infallible<Void> { get }

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
