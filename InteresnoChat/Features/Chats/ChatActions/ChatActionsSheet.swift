//
//  ChatActionsSheet.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct ChatActionsSheet: View {

    let onClose: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            action("Архивировать")
            action("Отметить как непрочитанное")
            action("Удалить у вас", color: .red)
        }
        .padding()
        .background(Color(hex: "#1C1C1E"))
        .cornerRadius(16)
        .padding(.horizontal)
    }

    func action(_ title: String, color: Color = .white) -> some View {
        Button(title) {
            onClose()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .foregroundColor(color)
        .background(Color(hex: "#2C2C2E"))
        .cornerRadius(10)
    }
}
