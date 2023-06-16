//
//  AppFlow.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 30/5/23.
//

import UIKit

import RxSwift

struct AppFlow {

    weak var window: UIWindow!

    func run() -> Completable {
        return SplashFlow(window: self.window)
            .run()
            .flatMapLatest { result in
                switch result {
                case .completed(let isSignedIn):
                    return self.showNextFlow(isSignedIn)
                }
            }
            .asObservable()
            .ignoreElements()
            .asCompletable()
    }

    func showNextFlow(_ isSignedIn: Bool) -> Infallible<Void> {
        return (isSignedIn
                ? MainFlow(window: self.window).run().map { false }
                : LoginFlow(window: self.window).run().map { true })
            .flatMapLatest(self.showNextFlow)
    }
}
