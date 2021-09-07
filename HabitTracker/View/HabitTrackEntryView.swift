//
//  HabitTrackEntryView.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct HabitTrackEntryView: View {
    @State private var habit: Habit?
    @Binding var habits: [Habit]
    let handler: (HabitTrack?) -> Void
    @State private var newHabitTitle = ""
    
    var body: some View {
        Form {
            Section(header: Text("Habit")) {
                TextField("New Habit", text: $newHabitTitle)
                
                HabitsSelectableList(
                    habits: habits,
                    selectedHabit: $habit
                )
            }
            
            Button("Cancel", action: cancelTapped)
            
            Button("Start", action: startTapped)
                .disabled(
                    habit == nil
                        && newHabitTitle.isEmpty
                )
        }
    }
    
    private func cancelTapped() {
        handler(nil)
    }
    
    private func startTapped() {
        let habit: Habit
        
        if !newHabitTitle.isEmpty {
            habit = Habit(
                id: UUID(),
                title: newHabitTitle,
                userId: UUID()
            )
            
            habits.append(habit)
        } else if let selectedHabit = self.habit {
            habit = selectedHabit
        } else {
            return
        }
        
        let habitTrack = HabitTrack(
            end: nil,
            id: UUID(),
            habitId: habit.id,
            start: Date().timeIntervalSince1970
        )
        
        handler(habitTrack)
    }
}

struct HabitTrackEntryView_Previews: PreviewProvider {
    @State static var habits = [
        Habit(id: UUID(), title: "No Drink", userId: UUID()),
        Habit(id: UUID(), title: "Wake Up Early", userId: UUID())
    ]
    
    static var previews: some View {
        HabitTrackEntryView(habits: $habits) { _ in
            
        }
    }
}
