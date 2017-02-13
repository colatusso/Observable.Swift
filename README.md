## Observable.Swift
  
UPDATE: Now you can add as much switches as you need, check the example project.
  
With this small piece of code (Observable.swift) you will be able to add reactivity programming to your app.  
Simple, useful and easy to use.

```swift
var n = Observable(1)
var c: Int = 0

n.valueDidChange = { [unowned self] in
    c = n.value // 2 then 3
}

n.value = 2
c // 2
n.value = 3
c // 3

// we can create and combine signals with Observable<T> properties
``` 
  
ObservableSwitch:  
With the ObservableSwitch you are able to combine signals and run some code depending on the status result.  
You can specify the bool state you are expecting to run the closure (available: .AnyState, .OnlyTrue, .OnlyFalse).  
Bellow we:
- enable/disable a UIButton based on the length of the username and password fields.  
- check for strong passwords (length > 10)  
- check for the master password (.OnlyTrue)

```swift
// signin enabler switch
let obSwitch = ObservableSwitch(.AnyState)
obSwitch.action = { [unowned self] (status: Bool) -> () in
    self.signin.alpha   = (status) ? 1 : 0.5
    self.signin.enabled = status
}

// username and password are ObservableTextField properties
self.username.addSignal({ [unowned self] in self.username.count >= 4 }, toSwitch: obSwitch)
self.password.addSignal({ [unowned self] in self.password.count >= 4 }, toSwitch: obSwitch)

// strong passwords switch
let obSwitchGreatPassword = ObservableSwitch(.AnyState)
obSwitchGreatPassword.action = { [unowned self] (status: Bool) -> () in
    self.signin.backgroundColor = (status) ?
        UIColor.green :
        UIColor.blue
}

self.password.addSignal({ [unowned self] in self.password.count > 10 }, toSwitch: obSwitchGreatPassword)        

// master password switch
let obSwitchMasterPassword = ObservableSwitch(.OnlyTrue)
obSwitchMasterPassword.action = { (status: Bool) -> () in
    let alertController = UIAlertController(title: "I know!", message: "It rocks!!!", preferredStyle: .alert)
    let action = UIAlertAction(title: "=)", style: .default, handler: nil)
    alertController.addAction(action)
    
    self.present(alertController, animated: true, completion: nil)
}

self.password.addSignal({ [unowned self] in self.password.text == "swift rocks" }, toSwitch: obSwitchMasterPassword)

```

![Alt text](https://raw.githubusercontent.com/colatusso/Observable.Swift/master/example-images/Observable3.gif)

ObservableTextField:  

```swift
self.textField.textDidChange = { [unowned self] (text: String) -> () in
	self.label.text = "Hi \(text)!"
}
```

![Alt text](https://raw.githubusercontent.com/colatusso/Observable.Swift/master/example-images/Observable2.gif)

Observable<T>:  

```swift
// you can create signals for Observable<T> properties in case you need to observe/manage
// multiple properties/states

self.word.valueDidChange = { [unowned self] in
    self.label.text = self.word.value
    self.label.textColor = self.getRandomColor()
}
```

![Alt text](https://raw.githubusercontent.com/colatusso/Observable.Swift/master/example-images/Observable.gif)

## License
All this code is released under the MIT license.

