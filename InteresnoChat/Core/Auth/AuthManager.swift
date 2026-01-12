//
//  AuthManager.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class AuthManager: ObservableObject {
    
    enum State {
        case loading
        case onboarding
        case unauthorized
        case authorized
    }
    
    @Published private(set) var state: State = .loading
    
    private let launchStorage = AppLaunchStorage()
    private let sessionStorage = SessionStorage()
    private let tokenStorage = TokenStorage()
    private let authWebSocket = AuthWebSocket()
    
    init() {
        bootstrap()
    }
    
    func bootstrap() {
        // Проверяем онбординг первым делом
        if !launchStorage.hasSeenOnboarding {
            state = .onboarding
            return
        }
        
        // Проверяем наличие токена
        if tokenStorage.hasAccessToken {
            state = .authorized
        } else {
            Task {
                await createAnonymousSessionIfNeeded()
                state = .unauthorized
            }
        }
    }
    
    func finishOnboarding() {
        launchStorage.markSeen()
        bootstrap()
    }
    
    func authorized() {
        state = .authorized
    }
    
    func logout() {
        tokenStorage.clear()
        sessionStorage.clear()
        authWebSocket.disconnect()
        state = .unauthorized
        
        // Создаем новую анонимную сессию после выхода
        Task {
            await createAnonymousSessionIfNeeded()
        }
    }
    
    func startWebSocketAuth() {
        guard let sessionId = sessionStorage.sessionId else { return }
        
        authWebSocket.connect(sessionId: sessionId) { [weak self] in
            Task { @MainActor in
                self?.authorized()
            }
        }
    }
    
    /// Полный сброс состояния приложения для тестирования первого входа
    /// Сбрасывает токены, сессию, онбординг и возвращает в состояние первого запуска
    func resetToFirstLaunch() {
        tokenStorage.clear()
        sessionStorage.clear()
        launchStorage.clear()
        authWebSocket.disconnect()
        
        state = .loading
        
        // Перезапускаем bootstrap для создания новой анонимной сессии
        bootstrap()
    }
    
    // MARK: - Private
    
    private func createAnonymousSessionIfNeeded() async {
        guard sessionStorage.sessionId == nil else { return }
        
        do {
            let session: AnonymousSessionResponse = try await APIClient.shared.get(
                "/api/v1/auth/sessions/new"
            )
            sessionStorage.save(session.id)
        } catch {
            print("Session error:", error)
        }
    }
}

