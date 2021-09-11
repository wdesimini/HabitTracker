//
//  ContentView.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct ContentView<ViewModel: ContentViewModelInput>: View {
    @State var isAddingHabit = false
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            VStack {
                Text(viewModel.userSectionTitle)
                    .padding(.vertical)
                Text(viewModel.username)
            }
            .padding()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(viewModel.currentStreaksSectionTitle)
                        .padding(.vertical)
                    Spacer()
                    Button(
                        viewModel.addButtonTitle,
                        action: addHabit
                    )
                }
                HabitsList(
                    viewModel: HabitsListModel(
                        data: viewModel.dataManager,
                        userId: viewModel.userId
                    )
                )
            }
            .padding()
        }
        .sheet(isPresented: $isAddingHabit) {
            
        }
    }
    
    private func addHabit() {
        isAddingHabit = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ContentViewModel(dataManager: .preview)
        return ContentView(viewModel: viewModel)
    }
}
