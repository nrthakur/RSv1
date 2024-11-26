//
//  ContentView.swift
//  RSv1
//
//  Created by Nikunj Thakur on 2024-11-26.
//

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        ZStack {
            Color.black
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            VStack(spacing: 20){
                Text("Welcome").foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -100, y: -100)
                
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
                    // Sign Up
                } label: {
                    Text("Sign Up").bold()
                        .frame(width: 200, height: 40).background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.blue, .black], startPoint: .bottomTrailing, endPoint: .topLeading))
                        ).foregroundColor(.white)
                }.padding(.top)
                    .offset(y: 100)
                
                Button {
                    // Log In
                
                    
                } label: {
                    Text("Already Have An Account? Login")
                        .bold()
                        .foregroundColor(.white)
                }.padding(.top)
                    .offset(y: 110)
                
            }
            .frame(width: 350)
            
            
            
        }.ignoresSafeArea()
        
    
        
    }
}

#Preview {
    ContentView()
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
