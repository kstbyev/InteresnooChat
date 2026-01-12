//
//  AuthInterceptor.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import Foundation

final class AuthInterceptor {
    
    private let tokenStorage = TokenStorage()
    
    func intercept(_ request: inout URLRequest) {
        if let token = tokenStorage.accessToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
    
    func handleUnauthorized() async throws {
        // Попытка обновить токен
        try await APIClient.shared.refreshToken()
    }
}

