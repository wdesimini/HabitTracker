//
//  HabitTracksList.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

protocol HabitTracksListViewInput {
    func show(isEnteringHabitTrack: Bool)
}

struct HabitTracksList<ViewModel: HabitTracksListViewModelInput>: View, HabitTracksListViewInput {
    @State var isShowingTrackerEntry = false
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.habitTracks, id: \.id) {
                HabitTrackListItem(
                    habit: viewModel.habit(trackedBy: $0),
                    habitTrack: $0
                )
                .padding()
            }
            Button(viewModel.addTrackerButtonTitle) {
                show(isEnteringHabitTrack: true)
            }
            .frame(maxWidth: .infinity, minHeight: 54)
            Spacer()
        }
        .sheet(isPresented: $isShowingTrackerEntry) {
            HabitTrackEntryView(
                viewModel: HabitTrackEntryViewModel {
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
        let viewModel = HabitTracksListViewModel()
        return HabitTracksList(viewModel: viewModel)
    }
}
