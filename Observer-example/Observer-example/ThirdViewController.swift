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
        obSwitch.action = { [unowned self] (status: Bool) -> () in
            self.signin.alpha     = (status) ? 1 : 0.5
            self.signin.isEnabled = status
        }
        
        self.username.addSignal({ [unowned self] in self.username.count >= 4 }, toSwitch: obSwitch)
        self.password.addSignal({ [unowned self] in self.password.count >= 4 }, toSwitch: obSwitch)
    }
}
