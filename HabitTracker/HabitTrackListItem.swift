//
//  HabitTrackListItem.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI


struct HabitTrackListItem: View {
    @State var habit: Habit
    @State var habitTrack: HabitTrack
    
    var body: some View {
        HStack {
            Text(habit.title)
            Spacer()
            Text(secondsElapsedText)
        }
    }
    
    var secondsElapsed: Int {
        Int(Date().timeIntervalSince1970 - habitTrack.start)
    }
    
    var secondsElapsedText: String {
        "\(secondsElapsed) seconds"
    }
}

struct HabitTrackListItem_Previews: PreviewProvider {
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
        
        return HabitTrackListItem(habit: habit, habitTrack: habitTrack)
    }
}
