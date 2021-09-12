//
//  HabitEntryView.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/12/21.
//

import SwiftUI

struct HabitEntryView<ViewModel: HabitEntryViewModelInput>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            TextField(
                viewModel.textFieldTitleKey,
                text: $viewModel.habitTitle
            )
            .padding(.vertical)
            HStack {
                Button(
                    viewModel.cancelButtonTitle,
                    action: viewModel.cancelTapped
                )
                .padding()
                .frame(maxWidth: .infinity)
                Button(
                    viewModel.submitButtonTitle,
                    action: viewModel.submitTapped
                )
                .disabled(viewModel.submitButtonDisabled)
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
        .padding()
    }
}

struct HabitEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let user = data.usersDataService.currentUser!
        let viewModel = HabitEntryViewModel(userId: user.id) { (_,_) in
            print("did complete habit entry")
        }
        return HabitEntryView(viewModel: viewModel)
    }
}
