//
//  OnboardingFirstImageView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct OnboardingFirstImageView: View {

    var body: some View {
        ZStack {

            // Большая белая звезда
            Image("ob_star_big")
                .resizable()
                .scaledToFit()
                .frame(width: 220)
                .offset(x: 40, y: 40)

            // Наушники
            Image("ob_headphones")
                .resizable()
                .scaledToFit()
                .frame(width: 140)
                .offset(x: -40, y: -40)

            // Синее кольцо
            Image("ob_ring")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .offset(x: -60, y: 60)

            // Цветок
            Image("ob_flower")
                .resizable()
                .scaledToFit()
                .frame(width: 36)
                .offset(x: 20, y: -90)
        }
        .frame(height: 320)
    }
}
