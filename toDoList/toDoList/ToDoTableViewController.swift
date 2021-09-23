//
//  ToDoTableViewController.swift
//  toDoList
//
//  Created by Ruslan Sanarkhin on 22.09.2021.
//

import UIKit

struct ToDoItem: Codable {
    var name: String
    var isCompleted = false
}

class ToDoTableViewController: UITableViewController {
    
    @IBOutlet var dataSource: ToDoTableViewDataSource!
    
    var toDoItems: [ToDoItem] {
        dataSource.toDoItems
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaults.resetStandardUserDefaults()
        dataSource.loadData()
    }
    
    //method to add item
    @IBAction func pushAddAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new item", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "New Item name"
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .default) { alert in
        }
        
        let alertActionCreate = UIAlertAction(title: "Create", style: .default) { alert in
            let text = alertController.textFields![0].text!
            self.dataSource.addItem(item: .init(name: text))
            self.tableView.reloadData()
        }
        
        alertController.addAction(alertActionCancel)
        alertController.addAction(alertActionCreate)
        present(alertController, animated: true, completion: nil)
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
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}
