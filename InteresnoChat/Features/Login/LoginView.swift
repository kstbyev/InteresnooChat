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
                    auth.startWebSocketAuthIfNeeded()
                    auth.showTelegramQR()
                } label: {
                    Text("Войти в приложение")
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button {
                    auth.startWebSocketAuthIfNeeded()
                    auth.showTelegramQR()
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
            // Если сессия уже есть, подготовим WebSocket при первом заходе
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
