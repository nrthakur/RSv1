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
    var onLoginSuccess: () -> Void // Closure to notify success

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
                    print("Error: \(error.localizedDescription)")
                }
                return
            }
            
            guard let user = result?.user else { return }
            print("User signed in successfully: \(user.email ?? "No Email")")

            // After successful login, notify the parent view
            onLoginSuccess()  // Trigger the onLoginSuccess closure

            // Retrieve user profile from Firestore
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { document, error in
                if let document = document, document.exists {
                    let data = document.data()
                    let fullName = data?["full_name"] as? String ?? "User"
                    print("User's full name: \(fullName)")
                    
                    // Use the data (e.g., display user name, profile picture)
                    // For example, update UI with user info
                } else {
                    print("User profile not found.")
                }
            }
            
            // After successful login, navigate to the home screen or another page
        }
    }
}

#Preview {
    LoginView(currentViewShowing: .constant("login"), onLoginSuccess: {})
}
