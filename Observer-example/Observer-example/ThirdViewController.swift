//
//  ThirdViewController.swift
//  Observer-example
//
//  Created by Rafael on 18/05/16.
//  Copyright © 2016 Rafael Colatusso. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet var username: ObservableTextField!
    @IBOutlet var password: ObservableTextField!
    @IBOutlet var signin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let obSwitch = ObservableSwitch()
        
        obSwitch.addSignal({ self.username.count >= 4 })
        obSwitch.addSignal({ self.password.count >= 4 })
        
        obSwitch.action = { (status: Bool) -> () in
            self.signin.alpha   = (status) ? 1 : 0.5
            self.signin.enabled = status
        }
        
        self.username.valueDidChange = { (text: String) -> () in
            obSwitch.validate()
        }
        
        self.password.valueDidChange = { (text: String) -> () in
            obSwitch.validate()
        }
    }
}
