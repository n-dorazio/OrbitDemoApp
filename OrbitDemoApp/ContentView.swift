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
                
                // Navigation to Log In Screen
                NavigationLink(destination: LoginScreen()) {
                    Text("Log In")
                }
                .buttonStyle(.borderedProminent)
                
                // Navigation to Join Screen
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
            
            ExploreScreen()
                .tabItem {
                    Label("Explore", systemImage: selectedTab == 1 ? "magnifyingglass.circle.fill" : "magnifyingglass")
                }
                .tag(1)
            
            CreateScreen()
                .tabItem {
                    Label("Create", systemImage: selectedTab == 2 ? "plus.circle.fill" : "plus.circle")
                }
                .tag(2)
            
            ProfileScreen()
                .tabItem {
                    Label("Profile", systemImage: selectedTab == 3 ? "person.fill" : "person")
                }
                .tag(3)
        }
        .accentColor(.blue)  // Highlight color of the selected tab
    }
}

// Sample user data model
struct User: Identifiable {
    let id = UUID()
    let name: String
    let interests: [String]
}

// Define the HomeScreen with user cards and interest filter
struct HomeScreen: View {
    @State private var selectedInterests: Set<String> = []
    
    // Sample list of users with interests
    let users = [
        User(name: "John Doe", interests: ["Basketball", "Video Games"]),
        User(name: "Jane Smith", interests: ["Cooking", "Video Games"]),
        User(name: "Alice Johnson", interests: ["Basketball", "Music"]),
        User(name: "Bob Lee", interests: ["Video Games", "Art"])
    ]
    
    let interests = ["All", "Basketball", "Video Games", "Cooking", "Music", "Reading", "Art"]
    
    var filteredUsers: [User] {
            if selectedInterests.isEmpty || selectedInterests.contains("All") {
                return users
            } else {
                return users.filter { user in
                    user.interests.contains(where: { selectedInterests.contains($0) })
                }
            }
        }
        
        var body: some View {
            VStack {
                // Filter options as a horizontal scroll view of capsules
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(interests, id: \.self) { interest in
                            Text(interest)
                                .padding()
                                .background(selectedInterests.contains(interest) ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(selectedInterests.contains(interest) ? Color.white : Color.black)
                                .clipShape(Capsule())
                                .onTapGesture {
                                    toggleInterest(interest)
                                }
                        }
                    }
                    .padding()
                }
            
            ScrollView {
                // Displaying user cards based on selected interest
                ForEach(filteredUsers) { user in
                    NavigationLink(destination: ProfileView(user: user)) {
                        UserCard(user: user)
                            .frame(maxWidth: .infinity, minHeight: 150)
                            .background(Color.orange.opacity(0.3))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .padding()
    }
    private func toggleInterest(_ interest: String) {
            if interest == "All" {
                selectedInterests = ["All"] // Reset to only "All"
            } else {
                if selectedInterests.contains("All") {
                    selectedInterests.remove("All") // Remove "All" if any other interest is selected
                }
                if selectedInterests.contains(interest) {
                    selectedInterests.remove(interest) // Deselect if already selected
                } else {
                    selectedInterests.insert(interest) // Select if not already selected
                }
            }
        }
}

// Custom view for a user card
struct UserCard: View {
    var user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.name)
                .font(.headline)
            Text(" \(user.interests.joined(separator: ", "))")
                .font(.footnote)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// Profile View for displaying detailed user information
struct ProfileView: View {
    var user: User
    
    var body: some View {
        VStack {
            Text(user.name)
                .font(.largeTitle)
                .bold()
            
            Text("Interests:")
                .font(.headline)
            
            ForEach(user.interests, id: \.self) { interest in
                Text(interest)
            }
            .padding(.top, 5)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
    }
}

struct ExploreScreen: View {
    var body: some View {
        VStack {
            Text("Explore Screen")
                .font(.largeTitle)
        }
    }
}

struct CreateScreen: View {
    var body: some View {
        VStack {
            Text("Create Screen")
                .font(.largeTitle)
        }
    }
}

struct ProfileScreen: View {
    var body: some View {
        VStack {
            Text("Profile Screen")
                .font(.largeTitle)
        }
    }
}

struct JoinScreen: View {
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
