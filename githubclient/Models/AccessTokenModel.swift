//
//  AccessTokenModel.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 31/5/23.
//

import Foundation

struct AccessTokenModel: Codable {
    let accessToken: String
    let tokenType: String
    let scope: String
}
