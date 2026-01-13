import Foundation
import SwiftUI
import Combine


@MainActor
final class AuthManager: ObservableObject {

    enum State {
        case loading
        case onboarding
        case unauthorized
        case telegramQR
        case authorized
    }

    @Published private(set) var state: State = .loading

    private let launchStorage = AppLaunchStorage()
    private let sessionStorage = SessionStorage()
    private let tokenStorage = TokenStorage()
    private let authWebSocket = AuthWebSocket()

    private var isAuthWebSocketActive = false

    // Публичный доступ к текущему sessionId для QR-экрана
    var currentSessionId: String? {
        sessionStorage.sessionId
    }

    init() {
        bootstrap()
    }

    func bootstrap() {
        if !launchStorage.hasSeenOnboarding {
            state = .onboarding
            return
        }

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
        isAuthWebSocketActive = false
        state = .unauthorized

        Task {
            await createAnonymousSessionIfNeeded()
        }
    }

    // MARK: - QR Flow control

    func showTelegramQR() {
        state = .telegramQR
    }

    func closeTelegramQR() {
        // Возвращаемся на экран логина (не авторизованы)
        if tokenStorage.hasAccessToken {
            state = .authorized
        } else {
            state = .unauthorized
        }
    }

    // MARK: - Auth WebSocket

    func startWebSocketAuthIfNeeded() {
        guard !isAuthWebSocketActive else { return }
        startWebSocketAuth()
    }

    func startWebSocketAuth() {
        guard let sessionId = sessionStorage.sessionId else { return }
        guard !isAuthWebSocketActive else { return }

        isAuthWebSocketActive = true

        authWebSocket.connect(sessionId: sessionId) { [weak self] in
            Task { @MainActor in
                self?.isAuthWebSocketActive = false
                self?.authorized()
            }
        }
    }

    // MARK: - Telegram

    func openTelegram() {
        guard let sessionId = sessionStorage.sessionId else { return }

        let raw = "session_\(sessionId)"
        guard let encoded = raw.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }

        if let tgUrl = URL(string: "tg://resolve?domain=InteresnoChatBot&start=\(encoded)"),
           UIApplication.shared.canOpenURL(tgUrl) {
            UIApplication.shared.open(tgUrl)
            return
        }

        if let webUrl = URL(string: "https://t.me/InteresnoChatBot?start=\(encoded)") {
            UIApplication.shared.open(webUrl)
        }
    }

    // MARK: - Reset

    func resetToFirstLaunch() {
        tokenStorage.clear()
        sessionStorage.clear()
        launchStorage.clear()
        authWebSocket.disconnect()
        isAuthWebSocketActive = false

        state = .loading
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
