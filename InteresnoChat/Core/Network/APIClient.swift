//
//  APIClient.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import Foundation

final class APIClient {
    
    static let shared = APIClient()
    private let baseURL = "https://interesnoitochka.ru"
    
    private init() {}
    
    func get<T: Decodable>(_ path: String) async throws -> T {
        var request = URLRequest(
            url: URL(string: baseURL + path)!
        )
        request.httpMethod = "GET"
        
        if let token = TokenStorage().accessToken() {
            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let http = response as? HTTPURLResponse,
           http.statusCode == 401 {
            throw APIError.unauthorized
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func refreshToken() async throws {
        let refresh = TokenStorage().refreshToken()!
        
        var request = URLRequest(
            url: URL(string:
              "\(baseURL)/api/v1/auth/jwt/refresh/new"
            )!
        )
        
        request.httpMethod = "POST"
        request.httpBody = "token=\(refresh)".data(using: .utf8)
        request.setValue(
            "application/x-www-form-urlencoded",
            forHTTPHeaderField: "Content-Type"
        )
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let tokens = try JSONDecoder().decode(AuthTokens.self, from: data)
        TokenStorage().save(tokens)
    }
}

