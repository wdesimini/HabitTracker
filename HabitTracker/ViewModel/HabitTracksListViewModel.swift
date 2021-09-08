//
//  HabitTracksListViewModel.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/7/21.
//

import Combine
import SwiftUI

protocol HabitTracksListViewModelInput: ObservableObject {
    var addTrackerButtonTitle: String { get }
    var habitTracks: [HabitTrack] { get }
    
    func add(habitTrack: HabitTrack)
    func habit(trackedBy habitTrack: HabitTrack) -> Habit
}

class HabitTracksListViewModel: HabitTracksListViewModelInput {
    @ObservedObject private var dataManager = DataManager.shared
    @Published private(set) var habitTracksById = [UUID: HabitTrack]()
    private var habitTracksObserver: AnyCancellable?
    
    init() {
        bind()
    }
    
    var addTrackerButtonTitle: String {
        "Add Tracker"
    }
    
    var habitTracks: [HabitTrack] {
        habitTracksById.values.sorted {
            habit(trackedBy: $0).title < habit(trackedBy: $1).title
        }
    }
    
    func add(habitTrack: HabitTrack) {
        let request = DataService<HabitTrack>.Request.create(object: habitTrack)
        let _ = dataManager.habitTracksDataService.execute(request: request)
        #warning("tbd - handle this response")
    }
    
    private func bind() {
        let service = dataManager.$habitTracksDataService
        
        habitTracksObserver = service.sink { [weak self] in
            self?.habitTracksById = $0.objectsById
        }
    }
    
    func habit(trackedBy habitTrack: HabitTrack) -> Habit {
        dataManager.habitsDataService.objectsById[habitTrack.habitId]!
    }
}
