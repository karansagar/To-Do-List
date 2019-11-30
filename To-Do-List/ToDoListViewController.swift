//
//  ViewController.swift
//  To-Do-List
//
//  Created by Karan Sagar on 30/11/19.
//  Copyright © 2019 Karan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    //Object
    //Database
    
    //UserDefaults saves in PLIST.
    //everything need to be there has key valye pairs.
    var defaults = UserDefaults()
    
    var itemArray = ["Save Bombay", "Give umbrella to Bunty", "Go kantabai's shop"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let items = defaults.array(forKey: "toDoListArr") as? [String] {
            itemArray = items
        }
    }
    
    //MARK:- TableView Datasource Method
    //Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK:-Cell for Row at index path
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK:- TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Select-Deselect/Remove Checkmarks
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //Remove grey highligh when we select table view cell
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Mark:- add New Item Button
    
    @IBAction func AddButtonPressed(_ sender: Any) {
        
        //Local Variable
        var textfield = UITextField()
        
        //Popup / UIAlert should appear
        // In UIAlert there should be text field to append on to-do-list array. and appear on the play.
        let alert = UIAlertController.init(title: "Add New To-Do-Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will heppen when the user clicks on the add item button on our Alert
            if textfield.text?.isEmpty == true {
                print("Please add item")
            } else {
                self.itemArray.append(textfield.text!)
                
                //Adding data to userDefaults.
                self.defaults.set(self.itemArray, forKey: "toDoListArr")
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textfield = alertTextField

        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    

    
    
    
}

