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
        Form {
            Section(header: Text(viewModel.userSectionTitle)) {
                Text(viewModel.username)
            }
            Section(header: Text(viewModel.habitTracksSectionTitle)) {
                HabitTracksList(viewModel: HabitTracksListViewModel())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ContentViewModel()
        return ContentView(viewModel: viewModel)
    }
}
