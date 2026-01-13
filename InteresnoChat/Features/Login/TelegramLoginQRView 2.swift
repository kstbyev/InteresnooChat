import SwiftUI

struct TelegramLoginQRView: View {

    @EnvironmentObject var auth: AuthManager

    private var qrImage: UIImage {
        let sessionId = auth.currentSessionId ?? ""
        let url = "https://t.me/InteresnoChatBot?start=session_\(sessionId)"
        return QRGenerator.generate(from: url)
    }

    var body: some View {
        ZStack {
            // Полноэкранный фон на отдельном слое
            Color(hex: "#0E0E10")
                .ignoresSafeArea()

            // Контент
            VStack(spacing: 24) {

                Spacer(minLength: 40)

                VStack(spacing: 12) {
                    Text("Вход через Telegram")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)

                    Text("Отсканируйте QR-код камерой\nили откройте Telegram по кнопке ниже")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 32)

                Image(uiImage: qrImage)
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 220, height: 220)
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.top, 12)

                VStack(spacing: 12) {
                    Button {
                        auth.openTelegram()
                    } label: {
                        Text("Открыть Telegram")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    Button {
                        auth.closeTelegramQR()
                    } label: {
                        Text("Закрыть")
                            .foregroundColor(.blue)
                            .padding(.top, 4)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)

                Spacer()
            }
        }
        .onAppear {
            // Гарантируем активный WebSocket; в AuthManager есть защита от повторного запуска
            auth.startWebSocketAuthIfNeeded()
        }
    }
}
