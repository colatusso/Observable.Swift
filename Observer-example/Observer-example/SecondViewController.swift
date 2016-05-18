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
    @IBOutlet var textView: ObservableTextView!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.textDidChange = {(text: String) -> () in
            self.label.text = "Hi \(text)!"
        }
        
        self.textView.textDidChange = {(text: String) -> () in
            print(text)
        }
    }
}
