//
//  ChecklistItem.swift
//  Checklists
//
//  Created by MOSHIOUR on 1/1/19.
//  Copyright © 2019 moshiour. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    
    var text = ""
    var checked = false
    
    func toggleChecked(){
        checked = !checked
    }
}

