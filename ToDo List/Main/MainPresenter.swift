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
    func updateTasksCount(to count: Int)
    func insertNewRowToTableView()
    func openTaskView(with task: ToDoModel)
    func deleteTheTask(at indexPath: IndexPath, id: String)
    func shareTheTask(task: ToDoModel)
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
        addToolBarItems(with: 0)
        addGestureRecognizerForHideKeyboard()
    }
    
    private func addGestureRecognizerForHideKeyboard() {
        guard let view = view as? MainViewController else { return }
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: view.view,
            action: #selector(view.view.endEditing)
        )
        
        view.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func reloadTableViewData() {
        view.tableView.reloadData()
    }
    
    func insertNewRowToTableView() {
        let indexPath = IndexPath(row: 0, section: 0)
        view.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func updateTasksCount(to count: Int) {
        addToolBarItems(with: count)
    }
    
    private func addToolBarItems(with countOfTasks: Int = 0) {
        let writeToDoButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.pencil"),
            style: .plain,
            target: self,
            action: #selector(addNewTask)
        )
        writeToDoButton.tintColor = UIColor.systemYellow
        let spacer = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let countOfTaskslabel = UILabel()
        countOfTaskslabel.textColor = .white
        countOfTaskslabel.textAlignment = .center
        countOfTaskslabel.font = .systemFont(ofSize: 11, weight: .light)
        countOfTaskslabel.text = "\(countOfTasks) Задач"
        
        let toolbarTitle = UIBarButtonItem(customView: countOfTaskslabel)
        
        guard let view = view as? MainViewController else { return }
        view.toolbarItems = [spacer, toolbarTitle, spacer, writeToDoButton]
        view.navigationController?.isToolbarHidden = false
        view.navigationController?.toolbar.isTranslucent = false
        view.navigationController?.toolbar.barStyle = .black
    }
    
    @objc private func addNewTask() {
        guard let viewController = view as? MainViewController else { return }
        
        let alertController = UIAlertController(
            title: "Новая задача",
            message: nil,
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(
                title: "Отменить",
                style: .destructive
            )
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "Добавить",
                style: .default,
                handler: { _ in
                    guard let title = alertController.textFields?.first?.text else { return }
                    guard let description = alertController.textFields?.last?.text else { return }
                        
                    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                        self?.interactor.addNemTask(title: title, description: description)
                        DispatchQueue.main.async {
                            self?.updateTasksCount(to: currentToDos.count)
                        }
                    }
                }
            )
        )
        alertController.addTextField()
        alertController.addTextField()
        
        alertController.textFields![0].placeholder = "Задача"
        alertController.textFields![1].placeholder = "Описание задачи"
        
        viewController.present(alertController, animated: true)
    }
    
    func openTaskView(with task: ToDoModel) {
        self.router.openTheTaskView(with: task)
    }
    
    func deleteRow(at indexPath: IndexPath) {
        view.tableView.deleteRows(at: [indexPath], with: .right)
    }
    
    func deleteTheTask(at indexPath: IndexPath, id: String) {
        
        for (index, toDo) in currentToDos.enumerated() {
            if toDo.id == id {
                currentToDos.remove(at: index)
                break
            }
        }
        
        for (index, toDo) in currentToDosCopy.enumerated() {
            if toDo.id == id {
                currentToDosCopy.remove(at: index)
                break
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.deleteRow(at: indexPath)
            self?.updateTasksCount(to: currentToDosCopy.count)
        }
    }
    
    func shareTheTask(task: ToDoModel) {
        
        guard let viewController = view as? MainViewController else { return }
        
        let sharedTaskString = """
            \(task.date)
            
            Задача: \(task.todo)
            
            Описание:
            \(task.taskDescription)
            """
        
        let activityViewController = UIActivityViewController(
            activityItems: [sharedTaskString],
            applicationActivities: []
        )
        
        viewController.present(activityViewController, animated: true)
    }

}
