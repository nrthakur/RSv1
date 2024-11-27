//
//  MainTabView.swift
//  RSv1
//
//  Created by Nikunj Thakur on 2024-11-27.
//


import SwiftUI
import FirebaseCrashlytics
import FirebaseAnalytics

struct MainTabView: View {
    var body: some View {
        TabView {
            ListingsView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Listings")
                }
                .tag(0)
                .onAppear {
                    Analytics.logEvent("view_listings", parameters: nil)
                }

            StarredView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Starred")
                }
                .tag(1)
                .onAppear {
                    Analytics.logEvent("view_starred", parameters: nil)
                }

            PostAdView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Post Ad")
                }
                .tag(2)
                .onAppear {
                    Analytics.logEvent("view_post_ad", parameters: nil)
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(3)
                .onAppear {
                    Analytics.logEvent("view_profile", parameters: nil)
                }
        }
        .accentColor(.blue)
    }
}


#Preview {
    MainTabView()
}
