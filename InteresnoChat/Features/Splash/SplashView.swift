//
//  SplashView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("InteresnoChat")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            ProgressView()
                .padding()
        }
    }
}

