//
//  MainViewController.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func addTitle()
    func addBackground()
    func addSearchBar()
    func addTableView()
    func addToolBarItems()
}

class MainViewController: UIViewController, MainViewProtocol {
    
    var searchBar: UISearchBar!
    var tableView: UITableView!
    
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()

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
        //tableView.separatorStyle = .singleLine
    }
    
    func addToolBarItems() {
        let writeToDoButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.pencil"),
            style: .plain,
            target: self,
            action: #selector(writeToDo)
        )
        writeToDoButton.tintColor = .systemYellow
        let spacer = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        var countOfTaskslabel = UILabel()
        countOfTaskslabel.textColor = .white
        countOfTaskslabel.textAlignment = .center
        countOfTaskslabel.font = .systemFont(ofSize: 11, weight: .light)
        countOfTaskslabel.text = "15 Задач"
        
        var toolbarTitle = UIBarButtonItem(customView: countOfTaskslabel)
        
        toolbarItems = [spacer, toolbarTitle, spacer, writeToDoButton]
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.isTranslucent = false
        navigationController?.toolbar.barStyle = .default
    }
    
    @objc func writeToDo() {
        
    }
    
}

extension MainViewController: UISearchBarDelegate {}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ToDoCell",
            for: indexPath
        ) as? TableViewCell else {
            fatalError("")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "TaskView") as? TaskViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
