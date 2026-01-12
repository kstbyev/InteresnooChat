//
//  LoginViewModel.swift
//  InteresnoChat
//
//  Created by Madi Sharipov on 10.01.2026.
//

import UIKit

final class LoginViewModel {

    func authorizeViaTelegram() {
        guard let sessionId = SessionStorage().sessionId else {
            fatalError("session_id not found")
        }

        let url = URL(
            string: "https://t.me/InteresnoChatBot?start=session_\(sessionId)"
        )!

        UIApplication.shared.open(url)
    }
}

