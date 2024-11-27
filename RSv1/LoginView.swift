//
//  LoginView.swift
//  RSv1
//
//  Created by Nikunj Thakur on 2024-11-26.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @Binding var currentViewShowing: String  // Bind the shared state
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            Color.black
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            VStack(spacing: 20){
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -100, y: -100)
                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text ("Email")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1).foregroundColor(.white)
                
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1).foregroundColor(.white)
                
                Button {
                    register()
                } label: {
                    Text("Log In")
                        .bold()
                        .frame(width: 200, height: 40).background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.blue, .black], startPoint: .bottomTrailing, endPoint: .topLeading))
                        ).foregroundColor(.white)
                }.padding(.top)
                    .offset(y: 100)
                
                Button {
                    withAnimation{
                        self.currentViewShowing = "signup" // Switch to Sign Up view
                    }
                } label: {
                    Text("Don't Have An Account? Sign Up")
                        .bold()
                        .foregroundColor(.white)
                }.padding(.top)
                    .offset(y: 110)
            }
            .frame(width: 350)
        }
        .ignoresSafeArea()
    }
    
    func register() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error as NSError? {
                // Handle Firebase Auth specific error codes
                switch AuthErrorCode(rawValue: error.code) {
                case .wrongPassword:
                    print("Incorrect password.")
                case .userNotFound:
                    print("No user found with this email.")
                default:
                    print("Authentication error: \(error.localizedDescription)")
                }
                return
            }
            
            guard let user = result?.user else {
                print("Unexpected error: No user object returned.")
                return
            }
            
            print("User signed in successfully: \(user.email ?? "No Email")")
            
            // Retrieve user profile from Firestore
            fetchUserProfile(for: user.uid) { profileData, error in
                if let error = error {
                    print("Failed to fetch user profile: \(error.localizedDescription)")
                    return
                }
                
                if let profileData = profileData {
                    print("User profile data: \(profileData)")
                    // Update UI or app state with user profile data
                } else {
                    print("User profile not found.")
                }
            }
            
            // Navigate to the home screen or another page
            navigateToHomeScreen()
        }
    }

    // Helper function to fetch user profile
    private func fetchUserProfile(for userID: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { document, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let document = document, document.exists, let data = document.data() {
                completion(data, nil)
            } else {
                completion(nil, nil) // Document does not exist
            }
        }
    }

    // Placeholder for navigating to the home screen
    private func navigateToHomeScreen() {
        // Add your navigation logic here
        print("Navigating to the home screen...")
        // Example:
        // self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }




}

#Preview {
    LoginView(currentViewShowing: .constant("login"))
}
