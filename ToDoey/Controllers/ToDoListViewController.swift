//
//  ViewController.swift
//  ToDoey
//
//  Created by Hammad Hassan on 17/06/2019.
//  Copyright © 2019 Talha. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [items]()
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItems = items()
        newItems.title = "Find Mike"
       itemArray.append(newItems)

        let newItems2 = items()
        newItems2.title = "cow"
        itemArray.append(newItems2)

        let newItems3 = items()
        newItems3.title = "hammad"
        itemArray.append(newItems3)
        if let items = defaults.array(forKey: "toDoListArray") as? [items] {
            itemArray = items
        
        
    }
    }
    
    
    //Mark- TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
     /////////   // Ternary Operator
     ////////   // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //Mark- TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        }else {
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.reloadData()
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Mark- Add New items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (Action) in
            // What will happen when user pressed Add button on UIAlert
            
            let newItem = items()
            newItem.title = textField.text!

            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "toDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    

}
