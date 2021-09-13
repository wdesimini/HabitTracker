//
//  TasksListItem.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/12/21.
//

import SwiftUI

struct TasksListItem<ViewModel: TasksListItemModelInput>: View {
    var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.taskTitle)
            Spacer()
            Text(viewModel.taskDueText)
                .opacity(0.5)
            Spacer()
            Button(
                viewModel.taskIsDone
                    ? viewModel.taskDoneText
                    : viewModel.finishedButtonTitle,
                action: viewModel.finishTapped
            )
            .disabled(viewModel.taskIsDone)
        }
        .padding()
    }
}

struct TasksListItem_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManager.preview
        let task = data.tasksDataService.objectsById.values.first!
        let viewModel = TasksListItemModel(data:data, task: task)
        return TasksListItem(viewModel: viewModel)
            .previewLayout(
                .fixed(width: 320, height: 54)
            )
    }
}
