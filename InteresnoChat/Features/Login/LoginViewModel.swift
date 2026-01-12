import Foundation
import Combine   // ❗ ВАЖНО

final class LoginViewModel: ObservableObject {

    private let auth: AuthManager

    init(auth: AuthManager) {
        self.auth = auth
    }

    func authorizeViaTelegram() {
        auth.startWebSocketAuth()
        auth.openTelegram()
    }
}

