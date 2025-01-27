//
//  ToDoModel.swift
//  ToDo List
//
//  Created by Никита Волков on 24.01.2025.
//

// For API
struct ToDoJSONModel: Codable {
    var id: Int
    var todo: String
    var completed: Bool
}
