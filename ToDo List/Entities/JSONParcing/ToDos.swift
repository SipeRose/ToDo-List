//
//  ToDos.swift
//  ToDo List
//
//  Created by Никита Волков on 26.01.2025.
//

struct ToDos: Codable {
    var todos: [ToDoJSONModel]
}


var currentToDos = [ToDoModel]()
var currentToDosCopy = [ToDoModel]()
