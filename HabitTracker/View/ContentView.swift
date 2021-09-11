//
//  ContentView.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct ContentView<ViewModel: ContentViewModelInput>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            VStack {
                Text(viewModel.userSectionTitle)
                    .padding(.vertical)
                Text(viewModel.username)
            }
            .padding()
            
            VStack {
                Text(viewModel.currentStreaksSectionTitle)
                    .padding(.vertical)
                HabitsList(
                    viewModel: HabitsListModel(
                        data: viewModel.dataManager,
                        userId: viewModel.userId
                    )
                )
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ContentViewModel(dataManager: .preview)
        return ContentView(viewModel: viewModel)
    }
}
