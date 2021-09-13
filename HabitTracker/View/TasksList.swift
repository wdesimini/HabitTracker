//
//  TasksList.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/12/21.
//

import SwiftUI

struct TasksList<ViewModel: TasksListModelInput>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.listTitle)
                Spacer()
            }
            .padding()
            ForEach(viewModel.tasks, id:\.id) { task in
                TasksListItem(
                    viewModel: viewModel.itemModel(task: task)
                )
            }
        }
    }
}

struct TasksList_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let user = data.usersDataService.currentUser!
        let viewModel = TasksListModel(data: data, userId: user.id)
        return TasksList(viewModel: viewModel)
    }
}
