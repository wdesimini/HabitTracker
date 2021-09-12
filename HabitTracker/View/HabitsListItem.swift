//
//  HabitsListItem.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/11/21.
//

import SwiftUI

struct HabitsListItem: View {
    @State var date = Date()
    @State var habit: Habit
    @State var currentStreak: Habit.Streak?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
        currentStreak.flatMap {
            Int(date.timeIntervalSince1970 - $0.start)  
        } ?? 0
    }
    
    var secondsElapsedText: String {
        "\(secondsElapsed) seconds"
    }
}

struct HabitsListItem_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let habit = data.habitsDataService.objectsById.values.first!
        let streak = data.streaksDataService.objectsById.values.first!
        return HabitsListItem(habit: habit, currentStreak: streak)
            .padding()
    }
}
