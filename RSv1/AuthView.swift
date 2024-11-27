//
//  AuthView.swift
//  RSv1
//
//  Created by Nikunj Thakur on 2024-11-26.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct AuthView: View {
    @State private var currentViewShowing: String = "login" // login or signup
    @State private var isUserLoggedIn = false

    var body: some View {
        VStack {
            if isUserLoggedIn {
                MainTabView()  // Show the main app screen if the user is logged in
            } else {
                if currentViewShowing == "login" {
                    LoginView(currentViewShowing: $currentViewShowing, onLoginSuccess: {
                        self.isUserLoggedIn = true  // Mark the user as logged in on success
                    })
                } else {
                    SignupView(currentViewShowing: $currentViewShowing)
                }
            }
        }
        .onAppear {
            // Check if the user is already logged in when the AuthView appears
            if Auth.auth().currentUser != nil {
                self.isUserLoggedIn = true
            }
        }
    }
}

#Preview {
    AuthView()
}
