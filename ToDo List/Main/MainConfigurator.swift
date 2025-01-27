//
//  MainConfigurator.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//

import Dispatch

protocol MainConfiguratorProtocol {
    func configure(with viewController: MainViewController)
}

class MainConfigurator: MainConfiguratorProtocol {
    
    func configure(with viewController: MainViewController) {
        let presenter = MainPresenter(view: viewController)
        let interactor = MainInteractor(presenter: presenter)
        let router = MainRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
        Task {
            if checkFirstParse() == nil {
                try await interactor.parseJSON()
            } else {
                interactor.getAllDataFromCoreData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    presenter.updateTasksCount(to: currentToDos.count)
                }
            }
        }
        
    }
    
}
