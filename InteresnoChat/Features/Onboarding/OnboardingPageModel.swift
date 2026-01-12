//
//  OnboardingPageModel.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import Foundation

struct OnboardingPageModel: Identifiable {
    let id = UUID()
    let image: String?
    let title: String
    let subtitle: String
    let isLast: Bool
}

let onboardingPages: [OnboardingPageModel] = [
    .init(
        image: nil,
        title: "Смотрите ваших блогеров",
        subtitle: "Тут какое-то описание в пару строчек\nкак классно можно делать что-то",
        isLast: false
    ),
    .init(
        image: "onboarding_2",
        title: "Общайтесь с друзьями",
        subtitle: "Тут какое-то описание в пару строчек\nкак классно можно делать что-то",
        isLast: false
    ),
    .init(
        image: "onboarding_3",
        title: "Делайте покупки в маркете",
        subtitle: "Тут какое-то описание в пару строчек\nкак классно можно делать что-то",
        isLast: false
    ),
    .init(
        image: "onboarding_4",
        title: "Участвуйте в акциях",
        subtitle: "Тут какое-то описание в пару строчек\nкак классно можно делать что-то",
        isLast: true
    )
]

