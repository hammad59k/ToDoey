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
   
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
    loadItems()
        
        
//        if let items = defaults.array(forKey: "toDoListArray") as? [items] {
//            itemArray = items
        
        
//    }
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
        
        saveItems()
        
        
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        }else {
//            itemArray[indexPath.row].done = false
//        }
        
       
        
        
        
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
           
           self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //Mark - Model Manupulation Method
    
    func saveItems () {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding itemArray,\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems (){
        if  let data = try? Data(contentsOf: dataFilePath!){
            let decorder = PropertyListDecoder ()
            do {
                itemArray = try decorder.decode([items].self, from: data)
            } catch {
                print("Error decoding ItemArray,\(error)")
            }
        }
    }

}
