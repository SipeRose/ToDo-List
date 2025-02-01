//
//  TaskInteractor.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//

import CoreData

protocol TaskInteractorProtocol {
    func saveToDoChanges(
        taskDescription: String,
        context: NSManagedObjectContext,
        toDoItem: ToDoDataItem
    )
}


class TaskInteractor: TaskInteractorProtocol {
    
    weak var presenter: TaskPresenterProtocol!
    
    init(presenter: TaskPresenterProtocol!) {
        self.presenter = presenter
    }
    
    func saveToDoChanges(taskDescription: String, context: NSManagedObjectContext, toDoItem: ToDoDataItem) {
        
        toDoItem.taskDescription = taskDescription
        do {
            try context.save()
        } catch {
            print("Problems while saving changes")
        }
        
    }
    
}
