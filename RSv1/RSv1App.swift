//
//  RSv1App.swift
//  RSv1
//
//  Created by Nikunj Thakur on 2024-11-26.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct RSv1App: App {
    @StateObject private var authViewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                MainTabView() // Show the main app view
            } else {
                AuthView() // Show login/signup screens
            }
        }
    }
}
