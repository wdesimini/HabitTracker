//
//  TasksListModel.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/12/21.
//

import Combine
import SwiftUI

protocol TasksListModelInput: ObservableObject {
    var listTitle: String { get }
    var tasks: [Task] { get }
    func itemModel(task: Task) -> TasksListItemModel
}

class TasksListModel: TasksListModelInput {
    @ObservedObject var data: DataManager
    @Published var tasks = [Task]()
    private var tasksObserver: AnyCancellable?
    private let userId: UUID
    private var userObserver: AnyCancellable?
    
    init(
        data: DataManager = .shared,
        userId: UUID
    ) {
        self.data = data
        self.userId = userId
        bind()
    }
    
    var listTitle: String {
        "Pending Tasks"
    }
    
    private func bind() {
        tasksObserver = data.$tasksDataService.sink { [weak self] in
            guard let self = self else {
                return
            }
            
            let tasksById = $0.objectsById
            self.tasks = self.tasks.compactMap { tasksById[$0.id] }
        }
        
        userObserver = data.$usersDataService.sink { [weak self] in
            guard let self = self,
                  let user = $0.objectsById[self.userId] else {
                return
            }
            
            let taskIds = user.taskIds
            let tasksById = self.data.tasksDataService.objectsById
            self.tasks = taskIds.compactMap { tasksById[$0] }
        }
    }
    
    func itemModel(task: Task) -> TasksListItemModel {
        TasksListItemModel(data: data, task: task)
    }
}
