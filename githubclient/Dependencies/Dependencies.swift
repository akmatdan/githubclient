//
//  Dependencies.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 30/5/23.
//

import Foundation

import Resolver

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        registerUseCases()
        registerScreens()
    }

    static func registerUseCases() {
        registerLocalStorageUseCase()
        registerGithubLoginUseCase()
    }

    static func registerScreens() {
        registerSplashScreen()
        registerLoginScreen()
    }
}
