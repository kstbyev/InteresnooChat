//
//  OnboardingFourthImageView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct OnboardingFourthImageView: View {

    var body: some View {
        ZStack {

            // Большая синяя звезда (фон)
            Image("ob_star_blue")
                .resizable()
                .scaledToFit()
                .frame(width: 220)
                .offset(x: -40, y: -40)

            // Фото
            Image("ob_sale_photo")
                .resizable()
                .scaledToFill()
                .frame(width: 220, height: 260)
                .clipped()
                .cornerRadius(12)

            // Белая звезда
            Image("ob_star_white")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .offset(x: 80, y: 60)

            // Лучи
            Image("ob_rays")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .offset(x: 60, y: 90)
        }
        .frame(height: 320)
    }
}
