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
    
    private let viewModel = LoginViewModel()

    var body: some View {
        VStack {

            Spacer(minLength: 40)

            // Декор
            LoginDecorView()

            Spacer(minLength: 32)

            // Тексты
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

            // Кнопки
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

            // Политика
            Text("При входе или регистрации вы соглашаетесь\nс нашей Политикой использования")
                .font(.system(size: 11))
                .foregroundColor(.white.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.top, 12)
            
            // Кнопка для тестирования
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
            // ВАЖНО: WebSocket открывается ДО открытия Telegram
            // Это критично для правильной работы авторизации
            auth.startWebSocketAuth()
        }
        .alert("Сбросить к первому входу?", isPresented: $showResetAlert) {
            Button("Отмена", role: .cancel) { }
            Button("Сбросить", role: .destructive) {
                auth.resetToFirstLaunch()
            }
        } message: {
            Text("Это действие сбросит все данные авторизации, сессию и онбординг. Приложение вернется в состояние первого запуска.")
        }
    }
}

