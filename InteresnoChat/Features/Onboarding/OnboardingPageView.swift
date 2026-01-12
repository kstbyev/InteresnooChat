//
//  OnboardingPageView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct OnboardingPageView: View {

    let page: OnboardingPageModel
    let index: Int

    var body: some View {
        VStack {

            Spacer(minLength: 40)

            // IMAGE BLOCK
            Group {
                switch index {
                case 0:
                    OnboardingFirstImageView()
                case 1:
                    OnboardingSecondImageView()
                case 2:
                    OnboardingThirdImageView()
                case 3:
                    OnboardingFourthImageView()
                default:
                    EmptyView()
                }
            }

            Spacer(minLength: 24)

            // Тексты
            VStack(spacing: 12) {
                Text(page.title)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Text(page.subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)

            Spacer()
        }
        .background(Color(hex: "#0E0E10"))
    }
}

