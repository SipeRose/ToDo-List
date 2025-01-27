//
//  TaskConfigurator.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//


protocol TaskConfiguratorProtocol {
    func configure(with taskViewController: TaskViewController)
}

final class TaskConfigurator: TaskConfiguratorProtocol {
    
    func configure(with taskViewController: TaskViewController) {
        let presenter = TaskPresenter(view: taskViewController)
        let interactor = TaskInteractor(presenter: presenter)
        
        taskViewController.presenter = presenter
        presenter.interactor = interactor
    }
    
}
