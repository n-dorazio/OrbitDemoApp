import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        VStack {
            Text("Profile Screen")
                .font(.largeTitle)
        }
    }
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