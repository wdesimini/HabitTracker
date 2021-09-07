//
//  ContentView.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct ContentView: View {
    @State var habits: [Habit]
    @State var habitTracksById: [UUID: HabitTrack]
    @State var user: User
    
    var body: some View {
        Form {
            Section(header: Text("User")) {
                Text(user.username)
            }
            Section(header: Text("Habit Tracks")) {
                HabitTracksList(
                    habits: habits,
                    habitTracksById: habitTracksById
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let habitId = UUID()
        let habitTrackId = UUID()
        let userId = UUID()
        
        let habit = Habit(
            id: habitId,
            title: "No Drink",
            userId: userId
        )
        
        let habitTrack = HabitTrack(
            end: nil,
            id: habitTrackId,
            habitId: habitId,
            start: Date().timeIntervalSince1970 - 3600
        )
        
        let user = User(
            id: UUID(),
            habitIds: Set([habitId]),
            habitTrackIds: Set([habitTrackId]),
            username: "Willy"
        )
        
        return ContentView(
            habits: [habit],
            habitTracksById: [habitTrackId: habitTrack],
            user: user
        )
    }
}
