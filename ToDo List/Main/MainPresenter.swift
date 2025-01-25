//
//  MainPresenter.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//

protocol MainPresenterProtocol {
    var router: MainRouterProtocol! { get set }
    func configureView()
}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol!
    var router: MainRouterProtocol!
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view.addBackground()
        view.addTitle()
        view.addSearchBar()
        view.addTableView()
        view.addToolBarItems()
    }
}
