//
//  MainPresenter.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//

import UIKit

protocol MainPresenterProtocol: AnyObject {
    var router: MainRouterProtocol! { get set }
    var interactor: MainInteractorProtocol! { get set }
    func configureView()
    func reloadTableViewData()
    func updateTasksCount()
}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view.addBackground()
        view.addTitle()
        view.addSearchBar()
        view.addTableView()
        view.addToolBarItems(with: 0)
    }
    
    func reloadTableViewData() {
        view.tableView.reloadData() 
    }
    
    func updateTasksCount() {
        view.addToolBarItems(with: firstToDos.count)
    }
}
