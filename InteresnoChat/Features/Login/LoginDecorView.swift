//
//  LoginDecorView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct LoginDecorView: View {
    var body: some View {
        ZStack {

            Image("login_star") // синяя фигура из Figma
                .resizable()
                .scaledToFit()
                .frame(width: 260)

            Image("icon_heart")
                .offset(x: -80, y: -60)

            Image("icon_chat")
                .offset(x: -100, y: 10)

            Image("icon_hand")
                .offset(x: 70, y: -40)
        }
        .padding(.top, 40)
    }
}

