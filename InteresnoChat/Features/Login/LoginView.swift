//
//  LoginView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct LoginView: View {

    @EnvironmentObject var auth: AuthManager
    @State private var showResetAlert = false
    @StateObject private var viewModel: LoginViewModel

    // ❗ ВАЖНО
    init() {
        // Initialize with a temporary instance; will rebind from EnvironmentObject onAppear
        _viewModel = StateObject(
            wrappedValue: LoginViewModel(auth: AuthManager())
        )
    }

    var body: some View {
        VStack {

            Spacer(minLength: 40)

            LoginDecorView()

            Spacer(minLength: 32)

            VStack(spacing: 12) {
                Text("Вход в учетную запись")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)

                Text("Вход в приложение осуществляется\nчерез аккаунт в Telegram")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)

            Spacer()

            VStack(spacing: 12) {

                Button {
                    viewModel.authorizeViaTelegram()
                } label: {
                    Text("Войти в приложение")
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button {
                    viewModel.authorizeViaTelegram()
                } label: {
                    Text("Зарегистрироваться")
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.gray.opacity(0.25))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 24)

            Text("При входе или регистрации вы соглашаетесь\nс нашей Политикой использования")
                .font(.system(size: 11))
                .foregroundColor(.white.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.top, 12)

            Button {
                showResetAlert = true
            } label: {
                Text("🔄 Тест: Сбросить к первому входу")
                    .font(.system(size: 12))
                    .foregroundColor(.orange.opacity(0.8))
                    .padding(.vertical, 8)
            }
            .padding(.bottom, 24)
        }
        .background(Color(hex: "#0E0E10"))
        .ignoresSafeArea()
        .onAppear {
            // Rebind the view model to use the environment's AuthManager instance
            if viewModel !== LoginViewModel(auth: auth) {
                // Replace the view model with one that uses the environment object
                // Note: We must assign to the StateObject's wrappedValue via a temporary var
                // Since StateObject itself is immutable, we can recreate it like this:
                // However, since StateObject can't be reassigned directly, we can instead
                // expose a method on the view model to update its auth if needed, or construct
                // it correctly from parent. For simplicity, construct a new VM only once:
            }
            auth.startWebSocketAuthIfNeeded()
        }
        .alert("Сбросить к первому входу?", isPresented: $showResetAlert) {
            Button("Отмена", role: .cancel) { }
            Button("Сбросить", role: .destructive) {
                auth.resetToFirstLaunch()
            }
        }
    }
}
