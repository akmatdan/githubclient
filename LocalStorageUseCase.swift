//
//  LocalStorageUseCase.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 31/5/23.
//

import Foundation

import Resolver

extension Resolver {

    static func registerLocalStorageUseCase() {
        register(ILocalStorageUseCase.self) { LocalStorageUseCase() }
    }
}

class LocalStorageUseCase: ILocalStorageUseCase {

    var accessToken: AccessTokenModel? {
        get {
            if let data = UserDefaults.standard.data(forKey: "accessToken"),
               let model = try? self.decoder.decode(AccessTokenModel.self, from: data)
            {
                return model
            }
            return nil
        }
        set {
            if let accessToken = newValue {
                if let data = try? self.encoder.encode(accessToken) {
                    UserDefaults.standard.set(data, forKey: "accessToken")
                }
            } else {
                UserDefaults.standard.removeObject(forKey: "accessToken")
            }
        }
    }

    lazy var decoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    lazy var encoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
}
