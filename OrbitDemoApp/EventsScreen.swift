import SwiftUI

struct EventsScreen: View {
    @State private var showingCreateEvent = false
    @State private var selectedSegment = 0
    
    @State private var allEvents = [
        Event(name: "Music Concert", date: "25th Sept", location: "City Park"),
        Event(name: "Basketball Tournament", date: "30th Sept", location: "Sports Arena"),
        Event(name: "Art Exhibition", date: "1st Oct", location: "Art Gallery")
    ]
    
    @State private var myEvents: [Event] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select View", selection: $selectedSegment) {
                    Text("All Events").tag(0)
                    Text("My Events").tag(1)
                }
                .pickerStyle(.segmented)
                .padding()
                
                if selectedSegment == 0 {
                    List(allEvents) { event in
                        NavigationLink(destination: EventDetailView(event: event, joinedEvents: $myEvents)) {
                            EventRow(event: event)
                        }
                    }
                } else {
                    List(myEvents) { event in
                        NavigationLink(destination: EventDetailView(event: event, joinedEvents: $myEvents, isMyEvent: true)) {
                            EventRow(event: event)
                        }
                    }
                }
                
                Button(action: {
                    showingCreateEvent.toggle()
                }) {
                    Text("Create Event")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .sheet(isPresented: $showingCreateEvent) {
                    CreateEventView(events: $allEvents)
                }
            }
            .navigationTitle("Events")
        }
    }
}

struct Event: Identifiable {
    let id = UUID()
    let name: String
    let date: String
    let location: String
    var isJoined: Bool = false
}

struct EventRow: View {
    var event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.name)
                .font(.headline)
            Text("Date: \(event.date)")
                .font(.subheadline)
        }
        .padding()
    }
}