//
//  TaskPresenter.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//

import UIKit
import NotificationCenter

protocol TaskPresenterProtocol: AnyObject {
    var router: TaskRouterProtocol! { get set }
    var interactor: TaskInteractor! { get set }
    func configureView()
}

class TaskPresenter: TaskPresenterProtocol {
    
    weak var taskView: TaskViewProtocol!
    var router: TaskRouterProtocol!
    var interactor: TaskInteractor!
    
    required init(view: TaskViewController) {
        self.taskView = view
    }
    
    func configureView() {
        taskView.addBackground()
        taskView.makeBackButtonColor()
        taskView.addTitle()
        taskView.addDateLabel()
        taskView.addTextView()
        addGestureRecognizerForHideKeyboard()
        notificationCenterObserversForKeyBoard()
    }
    
    private func addGestureRecognizerForHideKeyboard() {
        
        guard let view = taskView as? TaskViewController else { return }
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: view.textView,
            action: #selector(view.textView.endEditing)
        )
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(
            target: view.view,
            action: #selector(view.view.endEditing)
        )
        swipeGestureRecognizer.direction = .down
        
        view.view.addGestureRecognizer(tapGestureRecognizer)
        view.view.addGestureRecognizer(swipeGestureRecognizer)
        
    }

// MARK: Notifications for Keyboard while working with TextView
    private func notificationCenterObserversForKeyBoard() {
        
        let notificationenter = NotificationCenter.default
        notificationenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        notificationenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
        
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        guard let taskViewController = taskView as? TaskViewController
        else { return }
        
        let keyboardScreenAndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = taskViewController.view.convert(
            keyboardScreenAndFrame,
            from: taskViewController.view.window
        )
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            taskViewController.textView.contentInset = .zero
        } else {
            taskViewController.textView.contentInset = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: keyboardViewEndFrame.height - taskViewController.view.safeAreaInsets.bottom,
                right: 0
            )
        }
        
        taskViewController.textView.scrollIndicatorInsets = taskViewController.textView.contentInset
        
        let selectedRange = taskViewController.textView.selectedRange
        taskViewController.textView.scrollRangeToVisible(selectedRange)
        
    }
}
