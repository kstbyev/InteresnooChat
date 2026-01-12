//
//  RootView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

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
            
        case .authorized:
            ChatListView()
        }
    }
}
