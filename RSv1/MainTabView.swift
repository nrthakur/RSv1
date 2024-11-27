//
//  MainTabView.swift
//  RSv1
//
//  Created by Nikunj Thakur on 2024-11-27.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            ListingsView() // Replace with your actual ListingsView
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Listings")
                }
                .tag(0)

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(1)

            PostAdView() // Replace with your PostAdView
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Post Ad")
                }
                .tag(2)

            StarredView() // Replace with your StarredView
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Starred")
                }
                .tag(3)
        }
        .accentColor(.blue) // Customize this as per your theme
    }
}


#Preview {
    MainTabView()
}
