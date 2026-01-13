import SwiftUI

struct RootView: View {
    @EnvironmentObject var auth: AuthManager
    
    var body: some View {
        switch auth.state {
        case .loading:
            SplashView()
        case .onboarding:
            OnboardingView()
        case .unauthorized:
            LoginView()
        case .telegramQR:
            TelegramLoginQRView()
        case .authorized:
            ChatListView()
        }
    }
}
