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
    
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        ZStack {
            Color.black
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.blue, .black], startPoint: .bottomTrailing, endPoint: .topLeading))
            
            VStack(spacing: 20){
                Text("Create Account").foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -45, y: -100)
                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder (when: email.isEmpty) {
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
                    Text("Sign Up").bold()
                        .frame(width: 200, height: 40).background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.blue, .black], startPoint: .bottomTrailing, endPoint: .topLeading))
                        ).foregroundColor(.white)
                }.padding(.top)
                    .offset(y: 100)
                
                Button {
                    login()
                    
                    
                } label: {
                    Text("Already Have An Account? Log In")
                        .bold()
                        .foregroundColor(.white)
                }.padding(.top)
                    .offset(y: 110)
                
            }
            .frame(width: 350)
            
            
            
        }.ignoresSafeArea()
        
    
        
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
        
    }
    
    
}

#Preview {
    SignupView()
}


