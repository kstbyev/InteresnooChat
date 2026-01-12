//
//  ChatRowView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct ChatRowView: View {
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.gray)
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: 4) {
                Text("Lera234")
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .medium))

                Text("Отправил публикацию · 1 ч")
                    .foregroundColor(.gray)
                    .font(.system(size: 13))
            }

            Spacer()

            Text("25")
                .font(.system(size: 12))
                .padding(6)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
        .padding(.horizontal)
    }
}
