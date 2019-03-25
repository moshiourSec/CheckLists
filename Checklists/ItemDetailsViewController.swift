//
//  ItemDetailsViewController.swift
//  Checklists
//
//  Created by MOSHIOUR on 1/1/19.
//  Copyright © 2019 moshiour. All rights reserved.
//

import UIKit

protocol ItemDetailsViewControllerDelegate: class {
    func ItemDetailsViewControllerDidCancel(_ controller: ItemDetailsViewController)
    func ItemDetailsViewController(_ controller: ItemDetailsViewController, didFinishAdding item: ChecklistItem)
    func ItemDetailsViewController(_ controller: ItemDetailsViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailsViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    
    var editItem : ChecklistItem?
    
    weak var delegate: ItemDetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = editItem{
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancel(){
        
        navigationController?.popViewController(animated: true)
        delegate?.ItemDetailsViewControllerDidCancel(self)
    }
    
    @IBAction func doneButton(){
        
        if let itemEdit = editItem{
            itemEdit.text = textField.text!
            delegate?.ItemDetailsViewController(self, didFinishEditing: itemEdit)
        }else{
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            
            delegate?.ItemDetailsViewController(self, didFinishAdding: item)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        if newText.isEmpty{
            doneBarButton.isEnabled = false
        }else{
            doneBarButton.isEnabled = true
        }
        
        return true
    }



}
