//
//  ToDoDetailViewController.swift
//  toDoList
//
//  Created by Ruslan Sanarkhin on 27.09.2021.
//

import Foundation
import UIKit

class ToDoDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private var titleText = ""
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        titleLabel.text = titleText
    }
    
    // MARK: - Configure
    
    func configure(title: String) {
        titleText = title
    }
    
}
