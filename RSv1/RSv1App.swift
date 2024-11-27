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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView() // Use AuthView to manage switching between LoginView and SignupView
        }
    }
}
