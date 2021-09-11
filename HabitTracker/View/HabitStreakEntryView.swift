//
//  HabitStreakEntryView.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct HabitStreakEntryView<ViewModel: HabitStreakEntryViewModelInput>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            TextField(
                viewModel.habitTitleTextFieldPlaceholder,
                text: $viewModel.habitTitle
            )
            
            Button(
                viewModel.cancelButtonTitle,
                action: viewModel.cancelHabitTrackEntry
            )
            .frame(width: 120, height: 54)
            Button(
                viewModel.startButtonTitle,
                action: viewModel.startHabitTrack
            )
            .disabled(viewModel.startButtonIsDisabled)
            .frame(width: 120, height: 54)
        }
        .padding()
    }
}

struct HabitTrackEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HabitStreakEntryViewModel {}
        return HabitStreakEntryView(viewModel: viewModel)
    }
}
