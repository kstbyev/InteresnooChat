//
//  OnboardingThirdImageView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct OnboardingThirdImageView: View {

    var body: some View {
        ZStack {
            // Волнистая линия сверху
            // Width: 301.45px, Height: 235.36px, Top: 10px, Left: 63px
            Image("ob_wave_line")
                .resizable()
                .scaledToFit()
                .frame(width: 301.45, height: 235.36)
                .offset(x: 26.23, y: -32.32)

            // Фото
            // Width: 291px, Height: 260px, Top: 73px, Left: 42px
            Image("ob_market_photo")
                .resizable()
                .scaledToFill()
                .frame(width: 291, height: 260)
                .clipped()
                .cornerRadius(12)
                .offset(x: 0, y: 43)

            // Спираль
            // Width: 84.74px, Height: 194.13px, Top: 232.2px, Left: -47.87px, Rotation: -34.85°
            Image("ob_spiral")
                .resizable()
                .scaledToFit()
                .frame(width: 84.74, height: 194.13)
                .rotationEffect(.degrees(-34.85))
                .offset(x: -193, y: 169.27)

            // Звезда
            // Width: 153.11px, Height: 149.38px, Top: 249px, Left: 211px
            Image("ob_star_small")
                .resizable()
                .scaledToFit()
                .frame(width: 153.11, height: 149.38)
                .offset(x: 100.06, y: 163.69)
        }
        .frame(height: 320)
    }
}
