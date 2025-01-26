//
//  MainInteractor.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//

import UIKit

protocol MainInteractorProtocol {
    func parseJSON() async throws
}


class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenterProtocol!
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    func parseJSON() async throws {
        let urlString = "https://dummyjson.com/todos"
        
        guard let url = URL(string: urlString) else {
            throw requestError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw requestError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ToDos.self, from: data)
            firstToDos = result.todos
            firstToDosCopy = firstToDos
            
            DispatchQueue.main.async { [self] in
                self.presenter.reloadTableViewData()
                self.presenter.updateTasksCount()
            }
            
        } catch {
            throw requestError.invalidData
        }
    }
    
}
