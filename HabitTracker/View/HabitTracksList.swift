//
//  HabitTracksList.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

protocol HabitStreaksListViewInput {
    func show(isEnteringHabitTrack: Bool)
}

struct HabitTracksList<ViewModel: HabitStreaksListViewModelInput>: View, HabitStreaksListViewInput {
    @State var isShowingTrackerEntry = false
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.streaks, id: \.id) {
                HabitStreakListItem(
                    habit: viewModel.habit,
                    streak: $0
                )
                .padding()
            }
            Button(viewModel.addStreakButtonTitle) {
                show(isEnteringHabitTrack: true)
            }
            .frame(maxWidth: .infinity, minHeight: 54)
            Spacer()
        }
        .sheet(isPresented: $isShowingTrackerEntry) {
            HabitStreakEntryView(
                viewModel: HabitStreakEntryViewModel {
                    show(isEnteringHabitTrack: false)
                }
            )
        }
    }
    
    func show(isEnteringHabitTrack: Bool) {
        isShowingTrackerEntry = isEnteringHabitTrack
    }
}

struct HabitTracksList_Previews: PreviewProvider {
    static var previews: some View {
        let habit = Habit(
            id: UUID(),
            streakIds: Set<UUID>(),
            title: "No Drink",
            userId: UUID()
        )
        let viewModel = HabitStreaksListViewModel(habit: habit)
        return HabitTracksList(viewModel: viewModel)
    }
}
