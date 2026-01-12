//
//  OnboardingView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var auth: AuthManager
    @State private var page = 0

    var body: some View {
        VStack(spacing: 0) {

            TabView(selection: $page) {
                ForEach(Array(onboardingPages.enumerated()), id: \.offset) { index, item in
                    OnboardingPageView(page: item, index: index)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            OnboardingControls(
                page: page,
                total: onboardingPages.count,
                isLast: onboardingPages[page].isLast,
                next: next,
                skip: finish
            )
        }
        .ignoresSafeArea()
        .background(Color(hex: "#0E0E10"))
    }

    func next() {
        if page < onboardingPages.count - 1 {
            page += 1
        } else {
            finish()
        }
    }

    func finish() {
        auth.finishOnboarding()
    }
}

