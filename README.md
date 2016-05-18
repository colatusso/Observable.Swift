## Observable.Swift

This is a work in progress.  
There are many libraries in the Swift world to help you write reactive code,
and they are great! But I wanted to write something useful and simple.
With this small piece of code (Observable.swift) powered by generics you will be able to that.

```swift
var n = Observable(1)
var c: Int = 0

n.valueDidChange = {
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
Bellow you can see how we can enable/disable a UIButton based on the length of the username and password fields.

```swift
let obSwitch = ObservableSwitch()

// .count is a custom property from ObservableTextField used
// to get the correct count value inside the UITextField
// shouldChangeCharactersInRange delegate method

obSwitch.addSignal({ self.username.count >= 4 })
obSwitch.addSignal({ self.password.count >= 4 })

obSwitch.action = { (status: Bool) -> () in
    self.signin.alpha   = (status) ? 1 : 0.5
    self.signin.enabled = status
}

// .validate checks all signals inside the switch
// and return the status to the .action callback
self.username.valueDidChange = { (text: String) -> () in
    obSwitch.validate()
}

self.password.valueDidChange = { (text: String) -> () in
    obSwitch.validate()
}
```

![Alt text](https://raw.githubusercontent.com/colatusso/Observable.Swift/master/Observable3.gif)

ObservableTextField:  

```swift
self.textField.valueDidChange = {(text: String) -> () in
	self.label.text = "Hi \(text)!"
}
```

![Alt text](https://raw.githubusercontent.com/colatusso/Observable.Swift/master/Observable2.gif)

Observable<T>:  

```swift
self.word.valueDidChange = {
    self.label.text = self.word.value
    self.label.textColor = self.getRandomColor()
}
```

![Alt text](https://raw.githubusercontent.com/colatusso/Observable.Swift/master/Observable.gif)

## License
All this code is released under the MIT license.

