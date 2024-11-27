//
//  RSv1App.swift
//  RSv1
//
//  Created by Nikunj Thakur on 2024-11-26.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseAnalytics
import FirebaseCrashlytics

@main
struct RSv1App: App {
    
    @State private var isUserAuthenticated: Bool = false
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            // Observe authentication state
            Group {
                if isUserAuthenticated {
                    MainTabView() // Show MainTabView if user is authenticated
                } else {
                    AuthView() // Show AuthView (Login/Signup) if user is not authenticated
                }
            }
            .onAppear {
                // Listen to Firebase Auth state changes
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        // User is logged in
                        isUserAuthenticated = true
                    } else {
                        // User is not logged in
                        isUserAuthenticated = false
                    }
                }
            }
        }
    }
}
