//
//  AuthWebSocket.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import Foundation

final class AuthWebSocket {

    private var task: URLSessionWebSocketTask?

    func connect(
        sessionId: String,
        onSuccess: @escaping () -> Void
    ) {

        let url = URL(
            string: "ws://interesnoitochka.ru/api/v1/auth/sessions/ws/session/\(sessionId)"
        )!

        task = URLSession.shared.webSocketTask(with: url)
        task?.resume()

        listen(onSuccess)
    }

    private func listen(_ onSuccess: @escaping () -> Void) {
        task?.receive { [weak self] result in
            guard let self else { return }
            
            if case .success(.string(let text)) = result {
                self.handle(text, onSuccess)
                return
            }
            self.listen(onSuccess)
        }
    }

    private func handle(_ text: String, _ onSuccess: () -> Void) {
        guard let data = text.data(using: .utf8),
              let tokens = try? JSONDecoder().decode(AuthTokens.self, from: data)
        else { return }

        TokenStorage().save(tokens)
        task?.cancel()
        onSuccess()
    }
    
    func disconnect() {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
    }
}

