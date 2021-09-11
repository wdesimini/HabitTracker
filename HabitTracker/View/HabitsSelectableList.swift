//
//  HabitsSelectableList.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct HabitsSelectableList: View {
    @State var habits: [Habit]
    @Binding var selectedHabit: Habit?
    
    var body: some View {
        List {
            ForEach(habits, id: \.self) { habit in
                HStack {
                    Text(habit.title)
                    
                    Spacer()
                    
                    if habitIsSelected(habit) {
                        Image(systemName: "checkmark.circle")
                    }
                }
                .onTapGesture {
                    didSelect(habit: habit)
                }
            }
        }
    }
    
    private func didSelect(habit: Habit) {
        selectedHabit = habitIsSelected(habit) ? nil : habit
    }
    
    private func habitIsSelected(_ habit: Habit) -> Bool {
        selectedHabit.flatMap { $0.id == habit.id } ?? false
    }
}

struct HabitsSelectableList_Previews: PreviewProvider {
    @State static var selectedHabit: Habit?
    
    static var previews: some View {
        HabitsSelectableList(
            habits: [
                Habit(id: UUID(), streakIds: Set<UUID>(), title: "No Drink", userId: UUID()),
                Habit(id: UUID(), streakIds: Set<UUID>(), title: "Wake Up Early", userId: UUID())
            ],
            selectedHabit: $selectedHabit
        )
    }
}
