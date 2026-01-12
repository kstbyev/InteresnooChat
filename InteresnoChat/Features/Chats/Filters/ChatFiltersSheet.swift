//
//  ChatFiltersSheet.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct ChatFiltersSheet: View {

    let onClose: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text("Фильтры")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .padding(.top)
            
            // Здесь будут фильтры
            Text("Фильтры чатов")
                .foregroundColor(.gray)
                .padding()
            
            Spacer()
        }
        .padding()
        .background(Color(hex: "#1C1C1E"))
        .cornerRadius(16)
        .padding(.horizontal)
    }
}
