//
//  HabitTracksList.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct HabitTracksList: View {
    @State var isShowingTrackerEntry = false
    @State var habits: [Habit]
    @State var habitTracksById: [UUID: HabitTrack]
    
    var body: some View {
        VStack {
            ForEach(sortedHabitTracks, id: \.id) {
                HabitTrackListItem(
                    habit: habit(with: $0.habitId)!,
                    habitTrack: $0
                )
                .padding()
            }
            Button("Add Tracker") {
                isShowingTrackerEntry = true
            }
            Spacer()
        }
        .sheet(isPresented: $isShowingTrackerEntry) {
            HabitTrackEntryView(habits: $habits) {
                isShowingTrackerEntry = false
                
                guard let newHabitTrack = $0 else {
                    return
                }
                
                habitTracksById[newHabitTrack.id] = newHabitTrack
            }
        }
    }
    
    func habit(with id: UUID) -> Habit? {
        habits.filter { $0.id == id }.first
    }
    
    var sortedHabitTracks: [HabitTrack] {
        habitTracksById.values.sorted {
            let lhsTitle = habit(with: $0.habitId)?.title ?? ""
            let rhsTitle = habit(with: $1.habitId)?.title ?? ""
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
            habits: [habit],
            habitTracksById: [habitTrack.id: habitTrack]
        )
    }
}
