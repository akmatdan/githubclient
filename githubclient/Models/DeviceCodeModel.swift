//
//  DeviceCodeModel.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 31/5/23.
//

import Foundation

struct DeviceCodeModel: Codable {
    let deviceCode: String
    let userCode: String
    let verificationUri: URL
    let expiresIn: Int
    let interval: Int
}
