//
//  ViewController.swift
//  ToDo List
//
//  Created by Sunshine on 18/02/2018.
//  Copyright © 2018 Sunshine. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    
    @IBOutlet weak var importantCheckBox: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addClicked(_ sender: Any) {
    }
    
    
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

