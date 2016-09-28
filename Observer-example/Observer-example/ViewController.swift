//
//  ViewController.swift
//  Observer-example
//
//  Created by Rafael on 16/05/16.
//  Copyright © 2016 Rafael Colatusso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    let word = Observable(":)")
    
    var words: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resetSilvioIpsum()
        
        self.label.text = self.word.value
        self.word.valueDidChange = { [unowned self] in
            self.label.text = self.word.value
            self.label.textColor = self.getRandomColor()
        }
        
        self.rotate()
    }
    
    func rotate() {
        let delayTime = DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            if self.words.count > 0 {
                self.word.value = self.words.first!
                self.words.removeFirst()
            }
            else {
                self.resetSilvioIpsum()
            }
            
            self.rotate()
        }
    }
    
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
    func resetSilvioIpsum() {
        self.words = ["Silvio", "Santos", "Ipsum", "É", "namoro", "ou", "amizadeemm?", "Mah", "ooooee", "vem", "pra", "cá.", "Vem", "pra", "cá."]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

