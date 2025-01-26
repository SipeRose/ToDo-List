//
//  MainConfigurator.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//


protocol MainConfiguratorProtocol {
    func configure(with viewController: MainViewController)
}

class MainConfigurator: MainConfiguratorProtocol {
    
    func configure(with viewController: MainViewController) {
        let presenter = MainPresenter(view: viewController)
        let interactor = MainInteractor(presenter: presenter)
        // let router = MainRouter()
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        
        Task {
            try await presenter.interactor.parseJSON()
        }
    }
    
}
