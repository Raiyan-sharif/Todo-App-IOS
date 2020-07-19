//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//    
//        itemArray.append(Item(title: "Hello",done: false))
//        itemArray.append(Item(title: "Raiyan go",done: false))
 
        loadItems()
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)

        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    //Raiyan Sharif -
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Success")
            if let text = textField.text{
                if text == ""{
                    
                }
                else{
                    
                    let item = Item(context: self.context)
                    item.title = text
                    item.done = false
                    self.itemArray.append(item)
                    self.saveItems()
                    
//                    print(self.itemArray)
                }
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    func saveItems(){
        
        do{
            try context.save()
        }catch{
           print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(){
//        let data = try? Data(contentsOf: dataFilePath!)
//        let decoder = PropertyListDecoder()
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do{
//            itemArray = try decoder.decode([Item].self, from: data!)
            itemArray = try context.fetch(request)
        }catch{
            print("Error fatching data from context \(error)")
        }
    }
    
    
}

