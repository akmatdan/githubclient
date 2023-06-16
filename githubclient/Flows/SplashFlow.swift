//
//  SplashFlow.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 30/5/23.
//

import UIKit

import Resolver
import RxSwift

struct SplashFlow {

    weak var window: UIWindow!

    enum Result {
        case completed(isSignedIn: Bool)
    }

    func run() -> Infallible<Result> {
        return .deferred {
            let splash = Resolver.resolve(ISplashScreen.self) as! UIViewController & ISplashScreen
            self.window.rootViewController = splash
            self.window.makeKeyAndVisible()
            return splash.viewModel.onCompleted
        }
    }
}
