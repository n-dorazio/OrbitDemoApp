//
//  HomeScreen.swift
//  OrbitDemoApp
//
//  Created by Nathaniel D'Orazio on 2024-09-25.
//


import SwiftUI

struct HomeScreen: View {
    @State private var selectedInterests: Set<String> = []
    
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
                ForEach(filteredUsers) { user in
                    NavigationLink(destination: ProfileView(user: user)) {
                        UserCard(user: user)
                            .frame(maxWidth: .infinity, minHeight: 150)
                            .background(Color.orange.opacity(0.3))
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            
                    }
                }
            }
        }
    }
    
    private func toggleInterest(_ interest: String) {
        if interest == "All" {
            selectedInterests = ["All"]
        } else {
            if selectedInterests.contains("All") {
                selectedInterests.remove("All")
            }
            if selectedInterests.contains(interest) {
                selectedInterests.remove(interest)
            } else {
                selectedInterests.insert(interest)
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


struct User: Identifiable {
    let id = UUID()
    let name: String
    let interests: [String]
}

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

#Preview {
    HomeScreen()
}
