//
//  HabitView.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/12/21.
//

import SwiftUI

struct HabitView<ViewModel: HabitViewModelInput>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.habitTitle)
                .font(.title)
            List(viewModel.habitStreaks, id:\.id) { streak in
                Text("streak")
            }
            .padding()
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let habit = data.habitsDataService.objectsById.values.first!
        let viewModel = HabitViewModel(data: data, habit: habit)
        return HabitView(viewModel: viewModel)
    }
}
