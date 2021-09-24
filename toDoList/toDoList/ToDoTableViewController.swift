//
//  ToDoTableViewController.swift
//  toDoList
//
//  Created by Ruslan Sanarkhin on 22.09.2021.
//

import UIKit
import UserNotifications

struct ToDoItem: Codable {
    var name: String
    var isCompleted = false
}

class ToDoTableViewController: UITableViewController {
    
    @IBOutlet var dataSource: ToDoTableViewDataSource!
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        //tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func goSecondController(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let notePersonalController  = storyBoard.instantiateViewController(withIdentifier: "goSecondController") as! notePersonalController
        self.present(notePersonalController, animated: true, completion: nil)
    }
    
    
    @IBAction func callNotifications(_ sender: Any) {
        
        func requestForNotifications () {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
                if isEnabled {
                    print("Ok")
                } else {
                    print("Can't take a desigion")
                }
          }
        }
    }
    
    //method to add item
    @IBAction func pushAddAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Create New Action", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "write an action's name"
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .destructive) { alert in
        }
        
        let alertActionCreate = UIAlertAction(title: "Create", style: .cancel) { alert in
            let text = alertController.textFields![0].text
            if text != "" {
                self.dataSource.addItem(item: .init(name: text!))
                self.tableView.reloadData()
            }
        }
        
        
        alertController.addAction(alertActionCreate)
        alertController.addAction(alertActionCancel)
        present(alertController, animated: true, completion: nil)
    }
    
    var toDoItems: [ToDoItem] {
        dataSource.toDoItems
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaults.resetStandardUserDefaults()
        dataSource.loadData()
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
        
        //переход по ячейке
       // self.performSegue(withIdentifier: "showInfo", sender: tableView.cellForRow(at: indexPath))
//        let controller = notePersonalController(nibName: "YourNibName", bundle: nil)
//        self.present(controller, animated: true){
//          let destination = notePersonalController()
//          self.present(destination, animated: true)
//          self.navigationController?.pushViewController(destination, animated: true)
        }

    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) -> Void {
        dataSource.moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing{
            return .delete
        } else {
            return .delete
        }
        
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
}
