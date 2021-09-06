//
//  HabitTrackListItem.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct HabitTrackListItem: View {
    @State var date = Date()
    @State var habit: Habit
    @State var habitTrack: HabitTrack
    let timer = Timer.publish(
        every: 1, on: .main, in: .common
    ).autoconnect()
    
    var body: some View {
        HStack {
            Text(habit.title)
            Spacer()
            Text(secondsElapsedText)
        }
        .onReceive(timer) {
            date = $0
        }
    }
    
    var secondsElapsed: Int {
        Int(date.timeIntervalSince1970 - habitTrack.start)
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
        
        return HabitTrackListItem(
            date: Date(),
            habit: habit,
            habitTrack: habitTrack
        )
    }
}
