//
//  ProfileView.swift
//  RSv1
//
//  Created by Nikunj Thakur on 2024-11-27.
//

import SwiftUI
import FirebaseAuth
import Firebase

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
            
            // Check if user profile exists in Firestore
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { document, error in
                if let error = error {
                    print("Error fetching user profile: \(error.localizedDescription)")
                } else {
                    if let document = document, document.exists {
                        // Profile found, extract additional details (e.g., profile picture URL)
                        if let data = document.data(), let profilePicture = data["profile_picture"] as? String {
                            self.profilePictureURL = profilePicture
                        }
                    } else {
                        print("User profile not found, creating a default profile...")
                        // Optionally, create the profile here if not found
                        createDefaultUserProfile(for: user.uid)
                    }
                }
            }
        }
    }
    
    private func createDefaultUserProfile(for userID: String) {
        let db = Firestore.firestore()
        db.collection("users").document(userID).setData([
            "email": email,
            "uid": userID,
            "profile_picture": "",
            "created_at": Timestamp(date: Date())
        ]) { error in
            if let error = error {
                print("Error saving default profile: \(error.localizedDescription)")
            } else {
                print("Default user profile created.")
            }
        }
    }
    
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            showAuthView = true // Set flag to show AuthView
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
