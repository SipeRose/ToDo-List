//
//  MainInteractor.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//

import UIKit
import CoreData

protocol MainInteractorProtocol {
    func parseJSON() async throws
    func addNemTask(title: String, description: String)
    func deleteToDoData(data object: ToDoDataItem)
    func updateToDoData(toDoItem: ToDoDataItem, completed: Bool?, taskDescription: String?)
}


class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenterProtocol!
    let context: NSManagedObjectContext?
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    
    func parseJSON() async throws {
        let urlString = "https://dummyjson.com/todos"
        
        guard let url = URL(string: urlString) else { throw requestError.invalidURL }
        
        let (data, response) = try await {
            let request = URLRequest(url: url, timeoutInterval: 60.0)
            return try await URLSession.shared.data(for: request)
        }()
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else { throw requestError.invalidResponse }
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ToDos.self, from: data)
            
            for todo in result.todos {
                
                let title = todo.todo
                let description = ""
                let completed = todo.completed
                
                createNewToDoData(
                    date: "02/10/24",
                    todo: title,
                    taskDescription: description,
                    completed: completed
                )
                
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.presenter.reloadTableViewData()
                self?.presenter.updateTasksCount(to: currentToDos.count)
            }
            
        } catch {
            throw requestError.invalidData
        }
    }
    
    func addNemTask(title: String, description: String) {

        let date = getStringDate()
        let taskTitle = title
        let taskDescription = description
        let completed = false
        
        let newTask = createNewToDoData(
            date: date,
            todo: (taskTitle == "") ? "Без названия" : taskTitle,
            taskDescription: taskDescription,
            completed: completed
        )

        currentToDos.insert(newTask, at: 0)
        currentToDosCopy = currentToDos
        
        DispatchQueue.main.async { [weak self] in
            self?.presenter.insertNewRowToTableView()
        }
    }
    
    private func getStringDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        return dateFormatter.string(from: date)
    }
    
    // MARK: Core Data
    
    func getAllDataFromCoreData() {
        do {
            if let toDoData = try context?.fetch(ToDoDataItem.fetchRequest()) {
                currentToDos = toDoData
                currentToDosCopy = currentToDos
            }
        } catch {
            
        }
    }
    
    func createNewToDoData(date: String, todo: String, taskDescription: String, completed: Bool) -> ToDoDataItem {
        guard let context = context else { fatalError() }
        let newTask = ToDoDataItem(context: context)
        
        newTask.date = date
        newTask.todo = todo
        newTask.taskDescription = taskDescription
        newTask.completed = completed
        
        do {
            try context.save()
            getAllDataFromCoreData()
        } catch {
            print("Не удалось созранить ничего")
        }
        
        return newTask
    }
    
    func deleteToDoData(data object: ToDoDataItem) {
        guard let context = context else { return }
        context.delete(object)
        
        do {
            try context.save()
            //getAllDataFromCoreData()
        } catch {
            print("Не удалось сохранить")
        }
    }
    
    func updateToDoData(toDoItem: ToDoDataItem, completed: Bool?, taskDescription: String?) {
        
        guard let context = context else { return }
        
        if let completed = completed {
            toDoItem.completed = completed
        }
        
        if let taskDescription = taskDescription {
            toDoItem.taskDescription = taskDescription
        }
        
        do {
            try context.save()
            // getAllDataFromCoreData()
        } catch {
            
        }
    }

}
