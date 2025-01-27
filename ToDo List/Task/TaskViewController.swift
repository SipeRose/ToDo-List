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
    func addTextView()
}

class TaskViewController: UIViewController, TaskViewProtocol {
    
    var dateLabel: UILabel!
    var textView: UITextView!
    var date: String!
    var taskDescription: String!
    
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    func addDateLabel() {
        dateLabel = UILabel()
        if let date = date {
            dateLabel.text = date
        } else {
            dateLabel.text = "12/09/24"
        }
        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 14, weight: .light)
        
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    func addTextView() {
        textView = UITextView()
        view.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            textView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        textView.text = taskDescription
    }

}
