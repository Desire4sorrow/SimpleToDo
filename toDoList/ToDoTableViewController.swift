//
//  ToDoTableViewController.swift
//  toDoList
//
//  Created by Ruslan Sanarkhin on 22.09.2021.
//

import UIKit

struct ToDoItem {
    let name: String
    var isCompleted = false
}

class ToDoTableViewController: UITableViewController {
    
    @IBOutlet var dataSource: ToDoTableViewDataSource!
    
    var toDoItems: [ToDoItem] {
        dataSource.toDoItems
    }
    
    //method to add item
    @IBAction func pushAddAction(_ sender: Any) {
        dataSource.addItem(item: ToDoItem(name: "NewRow"))
        tableView.reloadData()
    }


    //to install amount of table rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoItems.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        dataSource.changeState(at: indexPath.row)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = toDoItems[indexPath.row].isCompleted ? .checkmark : .none
        
        saveData()
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func saveData(){
        print("data saved!")
    }

}
