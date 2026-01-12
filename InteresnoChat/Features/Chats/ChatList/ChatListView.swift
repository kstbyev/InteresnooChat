//
//  ChatListView.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import SwiftUI

struct ChatListView: View {

    @State private var showFilters = false
    @State private var showActions = false

    var body: some View {
        ZStack {
            VStack(spacing: 0) {

                // Header
                VStack(spacing: 12) {
                    Text("servise_car666")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)

                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Поиск")
                        Spacer()
                        Image(systemName: "slider.horizontal.3")
                            .onTapGesture { showFilters = true }
                    }
                    .padding(10)
                    .background(Color(hex: "#2C2C2E"))
                    .cornerRadius(10)
                }
                .padding()

                // Tabs
                HStack {
                    Text("Сообщения")
                        .foregroundColor(.white)
                    Text("Архив")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.horizontal)

                // List
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(0..<8, id: \.self) { _ in
                            ChatRowView()
                                .onLongPressGesture {
                                    showActions = true
                                }
                        }
                    }
                    .padding(.top)
                }
            }

            // Filters Sheet
            if showFilters {
                overlay {
                    ChatFiltersSheet {
                        showFilters = false
                    }
                }
            }

            // Actions Sheet
            if showActions {
                overlay {
                    ChatActionsSheet {
                        showActions = false
                    }
                }
            }
        }
        .background(Color(hex: "#0E0E10"))
    }

    func overlay<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    showFilters = false
                    showActions = false
                }

            VStack {
                Spacer()
                content()
            }
        }
        .transition(.move(edge: .bottom))
    }
}
