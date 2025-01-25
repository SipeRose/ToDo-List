//
//  TaskPresenter.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//

protocol TaskPresenterProtocol {
    var router: TaskRouterProtocol! { get set }
    func configureView()
}

class TaskPresenter: TaskPresenterProtocol {
    
    weak var taskView: TaskViewProtocol!
    var router: TaskRouterProtocol!
    
    required init(view: TaskViewController) {
        self.taskView = view
    }
    
    func configureView() {
        taskView.addBackground()
        taskView.makeBackButtonColor()
        taskView.addTitle()
        taskView.addDateLabel()
    }
}
