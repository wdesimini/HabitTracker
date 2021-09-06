//
//  HabitsList.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct HabitsList: View {
    @State var habits: [Habit]
    
    var body: some View {
        List(habits, id: \.id) { habit in
            Text(habit.title)
        }
    }
}

struct HabitsList_Previews: PreviewProvider {
    static var previews: some View {
        HabitsList(
            habits: [
                Habit(
                    id: UUID(),
                    title: "Brush Teeth",
                    userId: UUID()
                )
            ]
        )
    }
}
