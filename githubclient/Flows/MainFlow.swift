//
//  MainFlow.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 30/5/23.
//

import UIKit

import Resolver
import RxSwift

struct MainFlow {

    weak var window: UIWindow!

    func run() -> Infallible<Void> {
        return .deferred {
            let splash = Resolver.resolve(ILoginScreen.self) as! UIViewController & ILoginScreen
            self.window.rootViewController = splash
            return splash.viewModel.onCompleted
        }
    }
}

