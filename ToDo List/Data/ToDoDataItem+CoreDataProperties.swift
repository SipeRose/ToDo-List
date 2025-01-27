//
//  ToDoDataItem+CoreDataProperties.swift
//  ToDo List
//
//  Created by Никита Волков on 27.01.2025.
//
//

import Foundation
import CoreData


extension ToDoDataItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoDataItem> {
        return NSFetchRequest<ToDoDataItem>(entityName: "ToDoDataItem")
    }

    @NSManaged public var date: String?
    @NSManaged public var completed: Bool
    @NSManaged public var taskDescription: String?
    @NSManaged public var todo: String?

}
