//
//  HabitTrackEntryView.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct HabitTrackEntryView: View {
    let handler: (HabitTrack?) -> Void
    @State private var habitTitle = ""
    
    var body: some View {
        Form {
            Section(header: Text("Habit")) {
                TextField("New Habit", text: $habitTitle)
            }
            
            Button("Cancel", action: cancelTapped)
            
            Button("Start", action: startTapped)
                .disabled(habitTitle.isEmpty)
        }
    }
    
    private func add(habit: Habit) {
        #warning("tbd - handle failures here")
        let manager = DataManager.shared
        
        let _ = manager.habitsDataService.execute(
            request: .create(object: habit)
        )
    }
    
    private func cancelTapped() {
        handler(nil)
    }
    
    private func startTapped() {
        let habit = Habit(
            id: UUID(),
            title: habitTitle,
            userId: UUID()
        )
        
        let habitTrack = HabitTrack(
            end: nil,
            id: UUID(),
            habitId: habit.id,
            start: Date().timeIntervalSince1970
        )
        
        add(habit: habit)
        
        handler(habitTrack)
    }
}

struct HabitTrackEntryView_Previews: PreviewProvider {
    static var previews: some View {
        HabitTrackEntryView() { _ in
            
        }
    }
}
