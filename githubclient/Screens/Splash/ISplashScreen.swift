//
//  ISplashScreen.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 31/5/23.
//

import Foundation

import Resolver
import RxCocoa
import RxSwift

protocol ISplashScreen: AnyObject {

    var viewModel: ISplashViewModel! { get set }
}

protocol ISplashViewModel {

    var onCompleted: Infallible<SplashFlow.Result> { get }

    func transform(viewDidAppear: Signal<Void>) -> Completable
}

extension Resolver {

    static func registerSplashScreen() {
        register(ISplashViewModel.self) {
            SplashViewModel(localStorageUseCase: resolve())
        }
        register(ISplashScreen.self) { SplashViewController() }
            .resolveProperties { $1.viewModel = self.optional() }
    }
}
