//
//  IGithubLoginUseCase.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 31/5/23.
//

import Foundation

import RxSwift

protocol IGithubLoginUseCase {

    func deviceCode(clientId: String, scopes: [String]) -> Single<DeviceCodeModel>
    func oauthAccessToken(clientId: String, deviceCode: String, grantType: String) -> Single<AccessTokenModel>
}
