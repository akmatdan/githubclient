//
//  ILocalStorageUseCase.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 31/5/23.
//

import Foundation

protocol ILocalStorageUseCase: AnyObject {

    var accessToken: AccessTokenModel? { get set }
}
