//
//  MainViewController.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    
    var tableView: UITableView! { get set }
    
    func addTitle()
    func addBackground()
    func addSearchBar()
    func addTableView()
}

class MainViewController: UIViewController, MainViewProtocol {
    
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    
    var searchBar: UISearchBar!
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    func addTitle() {
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    func addBackground() {
        view.backgroundColor = UIColor.black
    }
    
    func addSearchBar() {
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: navigationItem.titleView?.bottomAnchor ?? view.safeAreaLayoutGuide.topAnchor)
        ])
        
        searchBar.barTintColor = .black
        searchBar.barStyle = .black
        searchBar.searchTextField.textColor = .white
        searchBar.placeholder = "Search"
        
    }
    
    func addTableView() {
        tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "ToDoCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.backgroundColor = .clear
    }
    
}


extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            currentToDos = currentToDosCopy
            
            if !searchText.isEmpty {
                currentToDos = currentToDosCopy.filter { $0.todo!.contains(searchText) }
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentToDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ToDoCell",
            for: indexPath
        ) as? TableViewCell else {
            fatalError("Error while making such cell")
        }
        
        cell.selectionStyle = .none
        
        cell.toDoItem = currentToDos[indexPath.row]
        cell.titleLabel.text = currentToDos[indexPath.row].todo
        cell.descriptionLabel.text = currentToDos[indexPath.row].taskDescription
        cell.taskDone = currentToDos[indexPath.row].completed
        cell.dateLabel.text = currentToDos[indexPath.row].date
        cell.ownerTableView = tableView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil,
            actionProvider: { suggestedActions in
                
                let edit = UIAction(
                    title: "Редактировать",
                    image: UIImage(systemName: "square.and.pencil"),
                    handler: { _ in
                        let task = currentToDos[indexPath.row]
                        self.presenter.openTaskView(with: task)
                    }
                )
                
                let share = UIAction(
                    title: "Поделиться",
                    image: UIImage(systemName: "square.and.arrow.up"),
                    handler: { _ in
                        let task = currentToDos[indexPath.row]
                        self.presenter.shareTheTask(task: task)
                    }
                )
                
                let delete = UIAction(
                    title: "Удалить",
                    image: UIImage(systemName: "trash"),
                    attributes: .destructive,
                    handler: { _ in
                        guard let cell = tableView.cellForRow(at: indexPath) as? TableViewCell else { return }
                        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                            self?.presenter.deleteTheTask(at: indexPath, toDoItem: cell.toDoItem)
                        }
                    }
                )
                
                return UIMenu(title: "", children: [edit, share, delete])
            }
        )
    }
    
}
