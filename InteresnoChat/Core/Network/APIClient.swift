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
    private let tokenStorage = TokenStorage()
    private let sessionStorage = SessionStorage()
    
    // Lock для предотвращения параллельных refresh
    private var refreshTask: Task<AuthTokens, Error>?
    
    private init() {}
    
    func get<T: Decodable>(_ path: String) async throws -> T {
        return try await performRequest(path: path, method: "GET", body: nil)
    }
    
    func post<T: Decodable>(_ path: String, body: Data? = nil) async throws -> T {
        return try await performRequest(path: path, method: "POST", body: body)
    }
    
    // MARK: - Private Request Handling
    
    private func performRequest<T: Decodable>(
        path: String,
        method: String,
        body: Data?
    ) async throws -> T {
        var request = try await buildRequest(path: path, method: method, body: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Проверяем на 401 ошибку
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
            // Пытаемся обновить токен и повторить запрос
            try await refreshTokenIfNeeded()
            request = try await buildRequest(path: path, method: method, body: body)
            let (retryData, retryResponse) = try await URLSession.shared.data(for: request)
            
            guard let retryHttp = retryResponse as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(retryHttp.statusCode) else {
                if retryHttp.statusCode == 401 {
                    throw APIError.unauthorized
                }
                throw APIError.networkError
            }
            
            return try JSONDecoder().decode(T.self, from: retryData)
        }
        
        // Валидация обычного ответа
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            if httpResponse.statusCode == 401 {
                throw APIError.unauthorized
            }
            throw APIError.networkError
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private func buildRequest(
        path: String,
        method: String,
        body: Data?
    ) async throws -> URLRequest {
        var request = URLRequest(
            url: URL(string: baseURL + path)!
        )
        request.httpMethod = method
        request.httpBody = body
        
        // Добавляем заголовки авторизации
        if let token = tokenStorage.accessToken() {
            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        } else {
            // Если не авторизован, добавляем X-Session-ID
            if let sessionId = sessionStorage.sessionId {
                request.setValue(sessionId, forHTTPHeaderField: "X-Session-ID")
            }
        }
        
        return request
    }
    
    private func refreshTokenIfNeeded() async throws {
        // Если уже идет обновление токена, ждем его завершения
        if let refreshTask = refreshTask {
            _ = try? await refreshTask.value
            return
        }
        
        // Проверяем, есть ли refresh_token
        guard let refreshToken = tokenStorage.refreshToken() else {
            throw APIError.unauthorized
        }
        
        // Создаем задачу обновления токена с lock
        refreshTask = Task {
            let tokens = try await performRefreshToken(refreshToken: refreshToken)
            self.refreshTask = nil
            return tokens
        }
        
        _ = try await refreshTask?.value
    }
    
    private func performRefreshToken(refreshToken: String) async throws -> AuthTokens {
        var request = URLRequest(
            url: URL(string: "\(baseURL)/api/v1/auth/jwt/refresh/new")!
        )
        
        request.httpMethod = "POST"
        request.httpBody = "token=\(refreshToken)".data(using: .utf8)
        request.setValue(
            "application/x-www-form-urlencoded",
            forHTTPHeaderField: "Content-Type"
        )
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.unauthorized
        }
        
        let tokens = try JSONDecoder().decode(AuthTokens.self, from: data)
        tokenStorage.save(tokens)
        return tokens
    }
}
