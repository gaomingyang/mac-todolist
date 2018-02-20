//
//  ViewController.swift
//  ToDo List
//
//  Created by Sunshine on 18/02/2018.
//  Copyright © 2018 Sunshine. All rights reserved.
//

import Cocoa

class ViewController: NSViewController,NSTableViewDataSource,NSTableViewDelegate {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var importantCheckBox: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var deleteButton: NSButton!
    
    var toDoItems : [ToDoItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getToDoItems()
    }
    
    func getToDoItems() {
        //从coredata获取数据
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            do {
                //set them to the class property
                toDoItems =  try context.fetch(ToDoItem.fetchRequest())
                //print(toDoItems.count)
            } catch {}
        }
        
        //更新数据
        tableView.reloadData()
    }
    
    func saveItem() {
        if textField.stringValue != "" {
            // print(textField.stringValue)
            
            if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let toDoItem = ToDoItem(context: context)
                toDoItem.name = textField.stringValue
                
                if importantCheckBox.state.rawValue == 0 {
                    //Not Important
                    toDoItem.important = false
                } else {
                    //Important
                    toDoItem.important = true
                }
                
                (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
                
                textField.stringValue = ""
                //importantCheckBox.state = 0   //不知道为什么这样写不行，查手册应该是可以的。
                
                getToDoItems()             //刷新
            }
        }
    }
    
    //点击增加按钮
    @IBAction func addClicked(_ sender: Any) {
        saveItem()
    }
    
    //响应回车键
    @IBAction func enterPressed(_ sender: Any) {
        saveItem()
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        let toDoItem = toDoItems[tableView.selectedRow]
        
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            context.delete(toDoItem)
            
            (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
            
            getToDoItems()
            
            deleteButton.isHidden = true
        }
    }
    
    // MARK: - TableView Stuff
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let toDoItem = toDoItems[row]
        
        if (tableColumn?.identifier)!.rawValue == "importantColumn" {
            //important cell
            if let cell = tableView.makeView(withIdentifier:NSUserInterfaceItemIdentifier(rawValue: "importantCell"), owner: self) as? NSTableCellView {
                
                if toDoItem.important {
                    cell.textField?.stringValue = "❗️"
                } else {
                    cell.textField?.stringValue = ""
                }
                return cell
            }
        } else {
            //Todo cell
            if let cell = tableView.makeView(withIdentifier:NSUserInterfaceItemIdentifier(rawValue: "todoCell"), owner: self) as? NSTableCellView {
                cell.textField?.stringValue = toDoItem.name!
                return cell
            }
        }
        
        return nil
    }
    
    //tableview选择一项时触发执行
    func tableViewSelectionDidChange(_ notification: Notification) {
        deleteButton.isHidden = false
    }
    
    
    
    

//    override var representedObject: Any? {
//        didSet {
//        // Update the view, if already loaded.
//        }
//    }


}

