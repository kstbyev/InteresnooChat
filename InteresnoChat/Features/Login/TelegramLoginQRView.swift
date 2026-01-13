//
//  TelegramLoginQRView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct TelegramLoginQRView: View {

    @EnvironmentObject var auth: AuthManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {

            Text("Вход через Telegram")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 24)

            Text("Нажмите кнопку ниже, чтобы открыть Telegram и подтвердить вход. Оставьте приложение открытым — мы автоматически обнаружим вход.")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            Spacer()

            // Placeholder area where a QR code could be shown in the future
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.08))
                .frame(width: 220, height: 220)
                .overlay(
                    VStack(spacing: 8) {
                        Image(systemName: "qrcode")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64, height: 64)
                            .foregroundColor(.white.opacity(0.7))
                        Text("Откройте бота InteresnoChatBot")
                            .font(.system(size: 13))
                            .foregroundColor(.white.opacity(0.7))
                    }
                )

            Spacer()

            VStack(spacing: 12) {
                Button {
                    auth.startWebSocketAuthIfNeeded()
                    auth.openTelegram()
                } label: {
                    Text("Открыть Telegram")
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button {
                    dismiss()
                } label: {
                    Text("Готово")
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.gray.opacity(0.25))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
        .background(Color(hex: "#0E0E10"))
        .ignoresSafeArea()
        .onAppear {
            // Ensure the WebSocket is connected, so the app can detect authorization
            auth.startWebSocketAuthIfNeeded()
        }
    }
}
