//
//  LoginView.swift
//  RSv1
//
//  Created by Nikunj Thakur on 2024-11-26.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignupView: View {
    @Binding var currentViewShowing: String  // Bind the shared state
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    
    var body: some View {
        ZStack {
            Color.black
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.blue, .black], startPoint: .bottomTrailing, endPoint: .topLeading))
            
            VStack(spacing: 20){
                Text("Create Account")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -40, y: -100)
                
                TextField("Full Name", text: $name)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: name.isEmpty) {
                        Text("Full Name")
                            .foregroundColor(.white)
                            .bold()
                    }
                Rectangle()
                    .frame(width: 350, height: 1).foregroundColor(.white)

                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
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
                    Text("Sign Up")
                        .bold()
                        .frame(width: 200, height: 40).background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.blue, .black], startPoint: .bottomTrailing, endPoint: .topLeading))
                        ).foregroundColor(.white)
                }.padding(.top)
                    .offset(y: 100)
                
                Button {
                    withAnimation{
                        self.currentViewShowing = "login" // Switch to Login view
                    }
                } label: {
                    Text("Already Have An Account? Log In")
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
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error as NSError? {
                // Handle Firebase Auth specific error codes
                switch AuthErrorCode(rawValue: error.code) {
                case .emailAlreadyInUse:
                    print("Email already in use.")
                case .weakPassword:
                    print("Password is too weak.")
                default:
                    print("Error: \(error.localizedDescription)")
                }
                return
            }
            
            guard let user = result?.user else { return }
            print("User created successfully: \(user.email ?? "No Email")")

            // Set up user profile in Firestore
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).setData([
                "email": user.email ?? "",
                "uid": user.uid,
                "full_name": name,
                "profile_picture": "", // You can leave this empty or add a default picture
                "created_at": Timestamp(date: Date())
            ]) { error in
                if let error = error {
                    print("Error saving user profile: \(error.localizedDescription)")
                } else {
                    print("User profile successfully saved.")
                }
            }
            
            // After successful signup, switch to the login view
            self.currentViewShowing = "login"
        }
    }



}

#Preview {
    SignupView(currentViewShowing: .constant("signup"))
}
