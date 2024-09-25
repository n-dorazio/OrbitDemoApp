//
//  ContentView.swift
//  OrbitDemoApp
//
//  Created by Nathaniel D'Orazio on 2024-09-24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Orbit")
                    .font(.largeTitle)
                    .bold()
                
                Image("Planet")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                NavigationLink(destination: LoginScreen()) {
                    Text("Log In")
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink(destination: JoinScreen()) {
                    Text("Join")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

struct LoginScreen: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeScreen()
                .tabItem {
                    Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
                }
                .tag(0)
            
            EventsScreen()
                .tabItem {
                    Label("Events", systemImage: selectedTab == 1 ? "calendar.circle.fill" : "calendar")
                }
                .tag(1)
            
            FriendScreen()
                .tabItem {
                    Label("Friends", systemImage: selectedTab == 2 ? "person.2.fill" : "person.2")
                }
                .tag(2)
            
            ProfileScreen()
                .tabItem {
                    Label("Profile", systemImage: selectedTab == 3 ? "person.fill" : "person")
                }
                .tag(3)
        }
        .accentColor(.blue)
    }
}

struct JoinScreen: View{
    var body: some View {
        VStack {
            Text("Account Creation")
                .font(.largeTitle)
        }
    }
}
#Preview {
    ContentView()
}
