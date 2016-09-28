## Observable.Swift

This is a work in progress.  
  
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
```

For more features like ObservableTextField take a look at the example project.  
  
ObservableSwitch:  
With the ObservableSwitch you are able to combine signals and run some code depending on the status result.
Bellow we enable/disable a UIButton based on the length of the username and password fields.

```swift
let obSwitch = ObservableSwitch()
obSwitch.action = { [unowned self] (status: Bool) -> () in
    self.signin.alpha   = (status) ? 1 : 0.5
    self.signin.enabled = status
}

// ObservableTextField properties
self.username.addSignal({ [unowned self] in self.username.count >= 4 }, toSwitch: obSwitch)
self.password.addSignal({ [unowned self] in self.password.count >= 4 }, toSwitch: obSwitch)

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
self.word.valueDidChange = {
    self.label.text = self.word.value
    self.label.textColor = self.getRandomColor()
}
```

![Alt text](https://raw.githubusercontent.com/colatusso/Observable.Swift/master/example-images/Observable.gif)

## License
All this code is released under the MIT license.

