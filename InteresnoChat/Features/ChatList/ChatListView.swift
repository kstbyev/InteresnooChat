//
//  ChatListView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var auth: AuthManager
    @State private var showResetAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Список чатов")
                    .font(.title)
                    .padding()
                
                Spacer()
                
                VStack(spacing: 16) {
                    Button("Выйти") {
                        auth.logout()
                    }
                    .padding()
                    
                    // Кнопка для тестирования первого входа
                    Button("🔄 Сбросить к первому входу (тест)") {
                        showResetAlert = true
                    }
                    .padding()
                    .background(Color.orange.opacity(0.2))
                    .foregroundColor(.orange)
                    .cornerRadius(8)
                }
            }
            .navigationTitle("Чаты")
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
}

