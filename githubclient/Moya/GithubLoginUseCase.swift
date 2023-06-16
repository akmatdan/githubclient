//
//  GithubLoginUseCase.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 31/5/23.
//

import Foundation

import Moya
import Resolver
import RxMoya
import RxSwift

extension Resolver {

    static func registerGithubLoginUseCase() {
        register(IGithubLoginUseCase.self) { GithubLoginUseCase() }
    }
}

struct GithubLoginUseCase: IGithubLoginUseCase {

    let provider = MoyaProvider<GithubLoginService>()

    func deviceCode(clientId: String, scopes: [String]) -> Single<DeviceCodeModel> {
        return self.provider.rx.request(.deviceCode(clientId: clientId, scopes: scopes))
            .map(DeviceCodeModel.self)
    }

    func oauthAccessToken(clientId: String, deviceCode: String, grantType: String) -> Single<AccessTokenModel> {
        return self.provider.rx.request(.oauthAccessToken(clientId: clientId, deviceCode: deviceCode, grantType: grantType))
            .map(AccessTokenModel.self)
    }
}

enum GithubLoginService: TargetType {

    case deviceCode(clientId: String, scopes: [String])
    case oauthAccessToken(clientId: String, deviceCode: String, grantType: String)

    var baseURL: URL {
        return URL(string: "https://github.com/login")!
    }

    var path: String {
        switch self {
        case .deviceCode: return "/device/code"
        case .oauthAccessToken: return "/oauth/access_token"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var task: Moya.Task {
        switch self {
        case .deviceCode(let clientId, let scopes):
            var parameters: [String: Any] = ["client_id" : clientId]
            if !scopes.isEmpty {
                parameters["scope"] = scopes.joined(separator: " ")
            }
            return .requestParameters(parameters: parameters,
                                      encoding: JSONEncoding.default)
        case .oauthAccessToken(let clientId, let deviceCode, let grantType):
            return .requestParameters(parameters: ["client_id": clientId,
                                                   "device_code" : deviceCode,
                                                   "grant_type" : grantType],
                                      encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Accept" : "application/json"]
    }
}
