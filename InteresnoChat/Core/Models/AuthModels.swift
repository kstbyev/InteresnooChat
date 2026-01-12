//
//  AuthModels.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import Foundation

struct AnonymousSessionResponse: Decodable {
    let id: String
}

struct AuthTokens: Decodable {
    let access_token: String
    let refresh_token: String
}
