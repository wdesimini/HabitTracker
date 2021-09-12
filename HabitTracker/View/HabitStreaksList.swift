//
//  HabitStreaksList.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/12/21.
//

import SwiftUI

struct HabitStreaksList<ViewModel: HabitStreaksListModelInput>: View {
    @State var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Streaks")
                .font(.subheadline)
                .padding()
            List(viewModel.streaks, id:\.id) { streak in
                VStack(alignment: .leading) {
                    Text(viewModel.dateText(streak: streak))
                        .font(.footnote)
                    Text(viewModel.durationText(streak: streak))
                        .font(.callout)
                }
            }
        }
    }
}

struct HabitStreaksList_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let streaks = [Habit.Streak](data.streaksDataService.objectsById.values)
        let viewModel = HabitStreaksListModel(streaks: streaks)
        return HabitStreaksList(viewModel: viewModel)
    }
}
