//
//  HabitsList.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct HabitsList<ViewModel: HabitsListModelInput>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.habits, id: \.id) { habit in
            HabitsListItem(
                habit: habit,
                currentStreak: viewModel.currentStreak(habit: habit)
            )
        }
    }
}

struct HabitsList_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let user = data.usersDataService.currentUser!
        let viewModel = HabitsListModel(data: data, userId: user.id)
        return HabitsList(viewModel: viewModel)
    }
}
