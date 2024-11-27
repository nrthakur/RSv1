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
    
    var body: some View {
        VStack {
            if currentViewShowing == "login" {
                LoginView(currentViewShowing: $currentViewShowing)
            } else {
                SignupView(currentViewShowing: $currentViewShowing)
            }
        }
    }
}

#Preview {
    AuthView()
}
