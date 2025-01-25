//
//  TaskViewController.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//

import UIKit

protocol TaskViewProtocol: AnyObject {
    func addBackground()
    func makeBackButtonColor()
    func addTitle()
    func addDateLabel()
}

class TaskViewController: UIViewController, TaskViewProtocol {
    
    var dateLabel: UILabel!
    
    var presenter: TaskPresenterProtocol!
    var configurator: TaskConfiguratorProtocol = TaskConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    func addBackground() {
        view.backgroundColor = .black
    }
    
    func makeBackButtonColor() {
        navigationController?.navigationBar.tintColor = .systemYellow
    }
    
    func addTitle() {
        title = "Тестовый заголовок"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    func addDateLabel() {
        dateLabel = UILabel()
        dateLabel.text = "12/09/24"
        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 12, weight: .light)
        
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

}
