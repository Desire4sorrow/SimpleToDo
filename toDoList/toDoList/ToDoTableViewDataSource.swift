//
//  ToDoTableViewDataSource.swift
//  toDoList
//
//  Created by Ruslan Sanarkhin on 22.09.2021.
//

import Foundation
import UIKit


class ToDoTableViewDataSource: NSObject, UITableViewDataSource {
    
    var toDoItems = [ToDoItem(name: "base", isCompleted: false)] {
        didSet {
            saveData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currentItem = toDoItems[indexPath.row]
        cell.textLabel?.text = currentItem.name
        cell.accessoryType = currentItem.isCompleted ? .checkmark : .none
        
        if tableView.isEditing {
            cell.textLabel?.alpha = 0.4
        } else {
            cell.textLabel?.alpha = 1.0
        }

        return cell
    }
    
    
    func addItem(item: ToDoItem) {
        toDoItems.append(item)
    }

    //delete element

    func removeItem(at index: Int) {
        toDoItems.remove(at: index)
        setBadge()
    }
       
    //changing state of row on click
    func changeState(at index: Int ){
        
        var item = toDoItems[index]
        item.isCompleted = !item.isCompleted
        //item.isCompleted.toggle()
    
        toDoItems.remove(at: index)
        toDoItems.insert(item, at: index)
        
        setBadge()
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            removeItem(at: indexPath.row)
            tableView.reloadData()
        case .insert:
            break
        default:
            break
        }
    }
    
    func saveData(){
        print("data saved!")
        UserDefaults.standard.set(try? JSONEncoder().encode(toDoItems), forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
    }
    
    func loadData(){
        if let data = UserDefaults.standard.data(forKey: "ToDoDataKey"),
           let array = try? JSONDecoder().decode([ToDoItem].self, from: data) {
            toDoItems = array
        }
        else
        {
            toDoItems = []
        }
    }
    
    func moveItem(fromIndex: Int, toIndex: Int)
    {
        let from = toDoItems[fromIndex]
        toDoItems.remove(at: fromIndex)
        toDoItems.insert(from, at: toIndex)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func setBadge(){
        UIApplication.shared.applicationIconBadgeNumber = toDoItems.filter(\.isCompleted).count
    }
}
