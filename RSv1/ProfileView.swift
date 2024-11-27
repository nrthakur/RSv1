import SwiftUI
import Firebase
import FirebaseAuth

struct ProfileView: View {
    @State private var fullName: String = "Loading..."
    @State private var profilePicture: String = "" // You can store the URL of the profile picture here.
    
    // New state variables for password update
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var passwordError: String? = nil // For showing error message
    @State private var showAlert = false // For showing the success alert
    @State private var alertMessage = "" // Message for alert

    @Environment(\.presentationMode) var presentationMode // For dismissing the view if needed
    
    var body: some View {
        VStack {
            // Profile Picture
            if let url = URL(string: profilePicture), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding()
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 120, height: 120)
                    .padding()
            }
            
            // Welcome Message
            Text("Hey \(fullName)!")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Spacer()

            // Password Update Section
            VStack {
                // Current Password Field
                SecureField("Current Password", text: $currentPassword)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.bottom, 10)

                // New Password Field
                SecureField("New Password", text: $newPassword)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                
                // Error Message (if any)
                if let error = passwordError {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                }

                // Update Password Button
                Button(action: updatePassword) {
                    Text("Update Password")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding([.horizontal, .bottom])
                }
            }
            .padding()

            // Sign Out Button
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
            .padding(.bottom, 20) // Optional, to add some bottom padding
        }
        .onAppear {
            fetchUserProfile()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func fetchUserProfile() {
        // Get current user
        guard let user = Auth.auth().currentUser else {
            return
        }

        // Fetch user data from Firestore
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                self.fullName = data?["full_name"] as? String ?? "User"
                self.profilePicture = data?["profile_picture"] as? String ?? "" // You can add default if empty
            } else {
                print("User profile not found.")
            }
        }
    }
    
    func updatePassword() {
        
        Analytics.logEvent("password_update", parameters: [
            "user_id": Auth.auth().currentUser?.uid ?? "unknown",
            "status": "started"
        ])
        
        // Validate new password length
        guard newPassword.count >= 6 else {
            passwordError = "New password must be at least 6 characters."
            return
        }
        
        guard let user = Auth.auth().currentUser else { return }
        
        // Re-authenticate the user before updating the password
        let credential = EmailAuthProvider.credential(withEmail: user.email!, password: currentPassword)
        
        user.reauthenticate(with: credential) { result, error in
            if error != nil {
                passwordError = "Current password is incorrect."
                return
            }
            
            // Update password
            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    passwordError = "Failed to update password: \(error.localizedDescription)"
                } else {
                    passwordError = nil
                    // Show success alert
                    alertMessage = "Password updated successfully!"
                    showAlert = true
                    
                    // Log the success message to the Xcode console
                    print("Password updated successfully!")  // <-- Log message here
                    
                    // Clear the password fields
                    currentPassword = ""
                    newPassword = ""
                    dismissKeyboard() // Dismiss the keyboard
                }
            }
        }
    }

    
    func signOut() {
        
        Analytics.logEvent("user_sign_out", parameters: [
                "user_id": Auth.auth().currentUser?.uid ?? "unknown"
            ])
        
        do {
            try Auth.auth().signOut()
            // After signing out, navigate to the login screen
            presentationMode.wrappedValue.dismiss()
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
