//
//  OnboardingSecondImageView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct OnboardingSecondImageView: View {

    var body: some View {
        ZStack {

            // Фото
            Image("ob_friends_photo")
                .resizable()
                .scaledToFill()
                .frame(width: 260, height: 180)
                .clipped()
                .cornerRadius(12)
                .offset(y: -10)

            // Синяя волна снизу
            Image("ob_wave")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .offset(y: 90)

            // Большое сердце
            Image("ob_heart_big")
                .resizable()
                .scaledToFit()
                .frame(width: 42)
                .offset(x: -120, y: -70)

            // Маленькое сердце
            Image("ob_heart_small")
                .resizable()
                .scaledToFit()
                .frame(width: 20)
                .offset(x: -95, y: -40)

            // Облако чата
            Image("ob_chat")
                .resizable()
                .scaledToFit()
                .frame(width: 46)
                .offset(x: 110, y: -80)
        }
        .frame(height: 320)
    }
}
