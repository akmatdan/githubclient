//
//  AppDelegate.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 30/5/23.
//

import UIKit

import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let disposeBag = DisposeBag()

    var window: UIWindow?

    var appFlow: AppFlow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        self.window = UIWindow()
        self.appFlow = AppFlow(window: window)

        self.appFlow?.run().subscribe().disposed(by: self.disposeBag)

        return true
    }
}
