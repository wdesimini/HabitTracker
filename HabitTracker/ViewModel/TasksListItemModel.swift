//
//  TasksListItemModel.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/12/21.
//

import Foundation

protocol TasksListItemModelInput {
    var finishedButtonTitle: String { get }
    var taskDoneText: String { get }
    var taskDueText: String { get }
    var taskIsDone: Bool { get }
    var taskTitle: String { get }
    func finishTapped()
}

class TasksListItemModel: TasksListItemModelInput {
    private var data: DataManager
    private let formatter: DateFormatter
    private var task: Task
    
    init(
        data: DataManager = .shared,
        task: Task
    ) {
        self.data = data
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        self.formatter = formatter
        self.task = task
    }
    
    var finishedButtonTitle: String {
        "Finish"
    }
    
    var taskDoneText: String {
        "Done"
    }
    
    var taskDueText: String {
        task.due.flatMap {
            let date = Date(timeIntervalSince1970: $0)
            return formatter.string(from: date)
        } ?? "No Due Date"
    }
    
    var taskIsDone: Bool {
        task.done != nil
    }
    
    var taskTitle: String {
        task.title
    }
    
    func finishTapped() {
        var task = self.task
        task.done = Date().timeIntervalSince1970
        let request = DataService<Task>.Request.update(object: task)
        #warning("tbd - handle response here?")
        let _ = data.tasksDataService.execute(request: request)
    }
}
