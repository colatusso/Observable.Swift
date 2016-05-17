//
//  SecondViewController.swift
//  Observer-example
//
//  Created by Rafael on 17/05/16.
//  Copyright © 2016 Rafael Colatusso. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet var textField: ObservableTextField!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.valueDidChange = {(text: String) -> () in
            self.label.text = "Hi \(text)!"
        }
    }
}
