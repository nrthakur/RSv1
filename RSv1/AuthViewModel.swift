//
//  AuthViewModel.swift
//  RSv1
//
//  Created by Nikunj Thakur on 2024-11-27.
//

import Foundation
import FirebaseAuth
import Firebase

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false

    init() {
        // Observe Firebase authentication stat
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.isAuthenticated = (user != nil)
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false  // This triggers the state change
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

