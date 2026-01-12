//
//  AuthWebSocket.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import Foundation

final class AuthWebSocket {

    private var task: URLSessionWebSocketTask?
    private var isUsingFallback = false

    func connect(
        sessionId: String,
        onSuccess: @escaping () -> Void
    ) {
        // Пробуем основной URL
        let primaryURL = URL(
            string: "ws://interesnoitochka.ru/api/v1/auth/sessions/ws/session/\(sessionId)"
        )!
        
        // Fallback URL
        let fallbackURL = URL(
            string: "ws://interesnoitochka.ru/api/v1/auth/sessions/ws/ws/session/\(sessionId)"
        )!
        
        connectToURL(primaryURL, fallbackURL: fallbackURL, sessionId: sessionId, onSuccess: onSuccess)
    }
    
    private func connectToURL(
        _ url: URL,
        fallbackURL: URL,
        sessionId: String,
        onSuccess: @escaping () -> Void
    ) {
        task = URLSession.shared.webSocketTask(with: url)
        task?.resume()

        listen(fallbackURL: fallbackURL, sessionId: sessionId, onSuccess: onSuccess)
    }

    private func listen(
        fallbackURL: URL,
        sessionId: String,
        onSuccess: @escaping () -> Void
    ) {
        task?.receive { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(.string(let text)):
                self.handle(text, sessionId: sessionId, onSuccess)
                return
            case .success(.data(let data)):
                if let text = String(data: data, encoding: .utf8) {
                    self.handle(text, sessionId: sessionId, onSuccess)
                    return
                }
            case .failure(let error):
                // Если ошибка и еще не использовали fallback, пробуем его
                if !self.isUsingFallback {
                    print("WebSocket primary URL failed, trying fallback:", error)
                    self.task?.cancel()
                    self.isUsingFallback = true
                    self.connectToURL(fallbackURL, fallbackURL: fallbackURL, sessionId: sessionId, onSuccess: onSuccess)
                    return
                }
                print("WebSocket error:", error)
            default:
                break
            }
            
            // Продолжаем слушать только если не получили токены
            self.listen(fallbackURL: fallbackURL, sessionId: sessionId, onSuccess: onSuccess)
        }
    }

    private func handle(_ text: String, sessionId: String, _ onSuccess: () -> Void) {
        guard let data = text.data(using: .utf8),
              let tokens = try? JSONDecoder().decode(AuthTokens.self, from: data)
        else { return }

        TokenStorage().save(tokens)
        
        // КРИТИЧНО: Удаляем session_id после получения токенов
        SessionStorage().clear()
        
        task?.cancel()
        onSuccess()
    }
    
    func disconnect() {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
        isUsingFallback = false
    }
}
