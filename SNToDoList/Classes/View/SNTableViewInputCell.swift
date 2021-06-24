//
//  SNTableViewInputCell.swift
//  SNToDoList
//
//  Created by 尚振兴 on 2021/6/23.
//

import UIKit

protocol TableViewInputCellDelegate:AnyObject {
    func inputChange (cell:SNTableViewInputCell,text:String)
}

class SNTableViewInputCell: UITableViewCell {

    weak var delegate:TableViewInputCellDelegate?
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func textFieldValueChange(_ sender: UITextField) {
        
        delegate?.inputChange(cell: self, text: sender.text ?? "")
    }
    
    
    
   
    
}
