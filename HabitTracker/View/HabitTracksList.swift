//
//  HabitTracksList.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct HabitTracksList: View {
    @State var isShowingTrackerEntry = false
    @ObservedObject var dataService = DataManager.shared
    
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
            HabitTrackEntryView {
                isShowingTrackerEntry = false
                
                guard let newHabitTrack = $0 else {
                    return
                }
                
                #warning("tbd - handle response here")
                let _ = dataService.habitTracksDataService.execute(
                    request: .create(object: newHabitTrack)
                )
            }
        }
    }
    
    func habit(with id: UUID) -> Habit? {
        dataService.habitsDataService.objectsById.values.filter { $0.id == id }.first
    }
    
    var sortedHabitTracks: [HabitTrack] {
        dataService.habitTracksDataService.objectsById.values.sorted {
            let lhsTitle = habit(with: $0.habitId)?.title ?? ""
            let rhsTitle = habit(with: $1.habitId)?.title ?? ""
            return lhsTitle < rhsTitle
        }
    }
}

struct HabitTracksList_Previews: PreviewProvider {
    static var previews: some View {
        HabitTracksList()
    }
}
