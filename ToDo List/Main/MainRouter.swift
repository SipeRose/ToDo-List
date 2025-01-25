//
//  MainRouter.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//


protocol MainRouterProtocol {
    
}

class MainRouter: MainRouterProtocol {
    
    weak var viewController: MainViewController!
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
}
