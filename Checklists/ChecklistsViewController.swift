//
//  ViewController.swift
//  Checklists
//
//  Created by MOSHIOUR on 1/1/19.
//  Copyright © 2019 moshiour. All rights reserved.
//

import UIKit

class ChecklistsViewController: UITableViewController, ItemDetailsViewControllerDelegate {
    
    func ItemDetailsViewControllerDidCancel(_ controller: ItemDetailsViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func ItemDetailsViewController(_ controller: ItemDetailsViewController, didFinishEditing item: ChecklistItem) {
        if let index = items.index(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                configureText(for: cell, with: item)
            }
            
        }
        navigationController?.popViewController(animated: true)
    }
    
    func ItemDetailsViewController(_ controller: ItemDetailsViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        
        navigationController?.popViewController(animated: true)
    }
    
    
    var items: [ChecklistItem]

    required init?(coder aDecoder: NSCoder) {
        
        items = [ChecklistItem]()
        
        let row0Item = ChecklistItem()
        row0Item.text = "Walk the dog"
        row0Item.checked = false
        items.append(row0Item)
        
        let row1Item = ChecklistItem()
        row1Item.text = "Brush my teeth"
        row1Item.checked = false
        items.append(row1Item)
        
        let row2Item = ChecklistItem()
        row2Item.text = "Learn iOS development"
        row2Item.checked = false
        items.append(row2Item)
        
        let row3Item = ChecklistItem()
        row3Item.text = "Soccer pratice"
        row3Item.checked = false
        items.append(row3Item)
        
        let row4Item = ChecklistItem()
        row4Item.text = "Eat ice cream"
        row4Item.checked = false
        items.append(row4Item)
        
        super.init(coder: aDecoder)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmark(for: cell, with: item)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
  
        
        configureCheckmark(for: cell, with: item)
        
        return cell
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
        
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        
        let newRowIndex = items.count
        
        let item = ChecklistItem()
        var titles = ["I am here", "Please come over me", "Tiger is our national animal","Hey!! you idiot", "Do, Whatever i say", "You are the wrong person", "Getout"]
        let randomNumber = arc4random_uniform(UInt32(titles.count))
        let title = titles[Int(randomNumber)]
        item.text = title
        item.checked = false
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        //let indexPaths = [indexPath]
        //tableView.deleteRows(at: indexPaths, with: .fade)
        tableView.reloadData()
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"{
            let controller = segue.destination as! ItemDetailsViewController
            controller.delegate = self
        }
        else if segue.identifier == "EditItem"{
            let controller = segue.destination as! ItemDetailsViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.editItem = items[indexPath.row]
            }
            
        }
    }
    

    

}

