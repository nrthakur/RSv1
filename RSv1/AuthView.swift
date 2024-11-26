//
//  AuthView.swift
//  RSv1
//
//  Created by Nikunj Thakur on 2024-11-26.
//

import SwiftUI

struct AuthView: View {
    @State private var currentViewShowing: String = "login" // login or signup
        
    var body: some View {
        
        if(currentViewShowing == "login") {
            LoginView()
        } else {
           SignupView()
        }
  
    }
}

#Preview {
    AuthView()
}
