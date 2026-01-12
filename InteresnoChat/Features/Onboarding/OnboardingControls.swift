//
//  OnboardingControls.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct OnboardingControls: View {
    let page: Int
    let total: Int
    let isLast: Bool
    let next: () -> Void
    let skip: () -> Void

    var body: some View {
        VStack(spacing: 16) {

            // Page dots
            HStack(spacing: 6) {
                ForEach(0..<total, id: \.self) { index in
                    Capsule()
                        .fill(index == page ? Color.blue : Color.gray.opacity(0.4))
                        .frame(width: index == page ? 18 : 6, height: 6)
                        .animation(.easeInOut, value: page)
                }
            }

            // Primary button
            Button(action: next) {
                Text(isLast ? "Зарегистрироваться" : "Далее")
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            // Skip
            if !isLast {
                Button(action: skip) {
                    Text("Пропустить")
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
        .background(Color(hex: "#0E0E10"))
    }
}

