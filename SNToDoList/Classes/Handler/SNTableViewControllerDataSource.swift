//
//  SNTableViewControllerDataSource.swift
//  SNToDoList
//
//  Created by 尚振兴 on 2021/6/24.
//

import UIKit

class SNTableViewControllerDataSource: NSObject,UITableViewDataSource {
    
    enum Section:Int {
        case input = 0,todos,max
    }
    
    var todos:[String]
    
    weak var owner:SNTableViewController?
    
    init(todos:[String],owner:SNTableViewController?) {
        self.todos = todos
        self.owner = owner
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.max.rawValue
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError()
        }
        switch section {
        case .input: return 1
        case .todos: return todos.count
        case .max: fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError()
        }
        
        switch section {
        case .input:
            let cell = tableView.dequeueReusableCell(withIdentifier: inputCellReuseId, for: indexPath) as! SNTableViewInputCell
            cell.delegate = owner
            return cell
        case .todos:
            let cell = tableView.dequeueReusableCell(withIdentifier: todoCellResueId, for: indexPath)
            cell.textLabel?.text = todos[indexPath.row]
            return cell
        default:
            fatalError()
        }
    }
    
    

}
