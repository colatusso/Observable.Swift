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
        
        let obSwitch = ObservableSwitch(.AnyState)
        obSwitch.action = { [unowned self] (status: Bool) -> () in
            self.signin.alpha     = (status) ? 1 : 0.5
            self.signin.isEnabled = status
        }
        
        self.username.addSignal({ [unowned self] in self.username.count >= 4 }, toSwitch: obSwitch)
        self.password.addSignal({ [unowned self] in self.password.count >= 4 }, toSwitch: obSwitch)
        
        // password length switch
        let obSwitchGreatPassword = ObservableSwitch(.AnyState)
        obSwitchGreatPassword.action = { [unowned self] (status: Bool) -> () in
            self.signin.backgroundColor = (status) ?
                UIColor.init(red: 0.0, green: 163/255.0, blue: 13/255.0, alpha: 1.0) :
                UIColor.init(red: 22/255.0, green: 133/255.0, blue: 193/255.0, alpha: 1.0)
        }
        
        self.password.addSignal({ [unowned self] in self.password.count > 10 }, toSwitch: obSwitchGreatPassword)
        
        // master pass switch
        let obSwitchMasterPassword = ObservableSwitch(.OnlyTrue)
        obSwitchMasterPassword.action = { (status: Bool) -> () in
            let alertController = UIAlertController(title: "I know!", message: "It rocks!!!", preferredStyle: .alert)
            let action = UIAlertAction(title: "=)", style: .default, handler: nil)
            alertController.addAction(action)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        self.password.addSignal({ [unowned self] in self.password.text == "swift rocks" }, toSwitch: obSwitchMasterPassword)

    }
}
