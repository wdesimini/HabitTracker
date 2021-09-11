//
//  HabitStreakListItem.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct HabitStreakListItem: View {
    @State var date = Date()
    @State var habit: Habit
    @State var streak: Habit.Streak
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
        Int(date.timeIntervalSince1970 - streak.start)
    }
    
    var secondsElapsedText: String {
        "\(secondsElapsed) seconds"
    }
}

struct HabitTrackListItem_Previews: PreviewProvider {
    static var previews: some View {
        let streak = Habit.Streak(
            end: TimeInterval(),
            id: UUID(),
            start: Date().timeIntervalSince1970 - 3600
        )
        
        let habit = Habit(
            id: UUID(),
            streakIds: Set([streak.id]),
            title: "No Drink",
            userId: UUID()
        )
        
        return HabitStreakListItem(date: Date(), habit: habit, streak: streak)
    }
}
