//
//  SNTableViewController.swift
//  SNToDoList
//
//  Created by 尚振兴 on 2021/6/23.
//

import UIKit

protocol ActionType {}
protocol StateType {}
protocol CommandType {}

let todoCellResueId: String = "todoCell";
let inputCellReuseId: String = "inputCell";

class SNTableViewController: UITableViewController {
    
//    var todos: [String] = []
    
    enum Section: Int {
        case input = 0, todos, max
    }
    
    struct State {
        let todos:[String]
        let text:String
    }
    
    var state = State(todos: [], text: ""){
        didSet{
            
            if oldValue.todos != state.todos {
                tableView.reloadData()
                title = "TODO -(\(state.todos.count))"
            }
            
            if (oldValue.text != state.text) {
                let isItemLengthEnough = state.text.count >= 3
                navigationItem.rightBarButtonItem?.isEnabled = isItemLengthEnough
                
                let inputIndexPath = IndexPath(row: 0, section: Section.input.rawValue)
                let inputCell = tableView.cellForRow(at: inputIndexPath) as? SNTableViewInputCell
                inputCell?.textField.text = state.text
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册Cell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: todoCellResueId)
        self.tableView.register(UINib.init(nibName: "SNTableViewInputCell", bundle: nil), forCellReuseIdentifier: inputCellReuseId)
        
        ToDoStore.shared.getToDoItems { (data) in
            //变更前
//            self.todos += data
//            self.title = "TODO - (\(self.todos.count))"
//            self.tableView.reloadData()
            
            //变更后
            self.state = State(todos:self.state.todos + data, text: self.state.text)
        }
    }
    
    //MARK: Action
    //添加代办
    @IBAction func addButtonPressed(_ sender: Any) {
        //变更前
//        let inputIndexPath = IndexPath(row: 0, section: Section.input.rawValue)
//        guard let inputCell = tableView.cellForRow(at: inputIndexPath) as? SNTableViewInputCell,
//              let text = inputCell.textField.text else {
//            return
//        }
//
//        todos.insert(text, at: 0)
//        inputCell.textField.text = ""
//        title = "TODO - (\(todos.count)"
//        tableView.reloadData()
        //变更后
        state = State(todos: [state.text] + state.todos, text: "")
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.max.rawValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = Section(rawValue: section) else {
            fatalError()
        }
        
        switch section {
        case .input: return 1
        case .todos: return state.todos.count
        case .max: fatalError()
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError()
        }
        
        switch section {
        case .input:
            // 返回 input cell
            let cell  = tableView.dequeueReusableCell(withIdentifier: inputCellReuseId, for: indexPath) as! SNTableViewInputCell
            cell.delegate = self
            return cell
        case .todos:
            // 返回 todo item cell
            let cell = tableView.dequeueReusableCell(withIdentifier: todoCellResueId, for: indexPath)
            cell.textLabel?.text = state.todos[indexPath.row]
            return cell
        default:
            fatalError()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.section == Section.todos.rawValue else {
            return
        }
        //变更前
//        todos.remove(at: indexPath.row)
//        title = "TODO - (\(todos.count))"
//        tableView.reloadData()
        
        //变更后
        let newTodos = Array(state.todos[...indexPath.row] + state.todos[(indexPath.row + 1)...])
        state = State(todos: newTodos, text: state.text)
    }
    
}

extension SNTableViewController: TableViewInputCellDelegate {
    
    func inputChange(cell: SNTableViewInputCell, text: String) {
        //变更前
//        let isItemLengthEnough = text.count >= 3
//        navigationItem.rightBarButtonItem?.isEnabled = isItemLengthEnough;
        //变更后
        state = State(todos: state.todos, text: text)
    }
}


