//
//  ProfileView.swift
//  RSv1
//
//  Created by Nikunj Thakur on 2024-11-27.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State private var email = ""
    @State private var profilePictureURL = ""
    @State private var showAuthView = false // For redirecting to AuthView on sign-out

    var body: some View {
        VStack {
            if let url = URL(string: profilePictureURL), !profilePictureURL.isEmpty {
                AsyncImage(url: url) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Circle().fill(Color.gray.opacity(0.5))
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding()
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 100, height: 100)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                    )
                    .padding()
            }

            Text(email)
                .font(.title)
                .bold()
                .padding()

            Spacer()

            Button(action: signOut) {
                Text("Sign Out")
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding([.horizontal, .bottom])
            }
        }
        .fullScreenCover(isPresented: $showAuthView) {
            AuthView()
        }
        .onAppear(perform: fetchUserData)
        .navigationTitle("Profile")
    }

    private func fetchUserData() {
        if let user = Auth.auth().currentUser {
            email = user.email ?? "No email"
            // Fetch profile picture URL from Firestore if applicable
        }
    }

    private func signOut() {
        do {
            try Auth.auth().signOut()
            showAuthView = true // Redirect to the authentication view
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
