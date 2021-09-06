//
//  HabitTracksList.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct HabitTracksList: View {
    @State var habitsById: [UUID: Habit]
    @State var habitTracks: [HabitTrack]
    
    var body: some View {
        List(habitTracks, id: \.id) {
            HabitTrackListItem(
                habit: habitsById[$0.habitId]!,
                habitTrack: $0
            )
        }
    }
}

struct HabitTracksList_Previews: PreviewProvider {
    static var previews: some View {
        let habit = Habit(
            id: UUID(),
            title: "No Drink",
            userId: UUID()
        )
        
        let habitTrack = HabitTrack(
            end: TimeInterval(),
            id: UUID(),
            habitId: habit.id,
            start: Date().timeIntervalSince1970 - 3600
        )
        
        return HabitTracksList(
            habitsById: [habit.id: habit],
            habitTracks: [habitTrack]
        )
    }
}