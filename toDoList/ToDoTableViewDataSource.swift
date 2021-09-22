//
//  ToDoTableViewDataSource.swift
//  toDoList
//
//  Created by Ruslan Sanarkhin on 22.09.2021.
//

import Foundation
import UIKit

class ToDoTableViewDataSource: NSObject, UITableViewDataSource {
    
    var toDoItems = [ToDoItem(name: "Call mommy", isCompleted: true)]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currentItem = toDoItems[indexPath.row]
        cell.textLabel?.text = currentItem.name
        cell.accessoryType = currentItem.isCompleted ? .checkmark : .none

        return cell
    }
    
    
    func addItem(item: ToDoItem) {
        toDoItems.append(item)
        
        
    }

    //delete element

    func removeItem(at index: Int) {
        toDoItems.remove(at: index)
    }
       
    //changing state of row on click
    func changeState(at index: Int ){
        
        var item = toDoItems[index]
        item.isCompleted = !item.isCompleted
        //item.isCompleted.toggle()
    
        toDoItems.remove(at: index)
        toDoItems.insert(item, at: index)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            removeItem(at: indexPath.row)
        case .insert:
            break
        default:
            break
        }
    }
}
