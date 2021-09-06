//
//  HabitTracksList.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct HabitTracksList: View {
    @State var habitsById: [UUID: Habit]
    @State var habitTracksById: [UUID: HabitTrack]
    
    var body: some View {
        List(sortedHabitTracks, id: \.id) {
            HabitTrackListItem(
                habit: habitsById[$0.habitId]!,
                habitTrack: $0
            )
        }
    }
    
    var sortedHabitTracks: [HabitTrack] {
        habitTracksById.values.sorted { (lhs, rhs) -> Bool in
            let lhsTitle = habitsById[lhs.habitId]?.title ?? ""
            let rhsTitle = habitsById[rhs.habitId]?.title ?? ""
            return lhsTitle < rhsTitle
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
            habitTracksById: [habitTrack.id: habitTrack]
        )
    }
}
