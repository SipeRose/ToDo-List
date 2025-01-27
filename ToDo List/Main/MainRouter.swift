//
//  MainRouter.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//


protocol MainRouterProtocol {
    func openTheTaskView(with task: ToDoDataItem)
}

class MainRouter: MainRouterProtocol {
    
    weak var viewController: MainViewController!
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func openTheTaskView(with task: ToDoDataItem) {
        if let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "TaskView") as? TaskViewController {
            vc.navigationItem.title = task.todo
            vc.date = task.date
            vc.taskDescription = task.taskDescription
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
