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

For more info take a look at the example project:  
ObservableTextField  

```swift
self.textField.valueDidChange = {(text: String) -> () in
	self.label.text = "Hi \(text)!"
}
```

![Alt text](https://raw.githubusercontent.com/colatusso/Observable.Swift/master/Observable2.gif)

Observable<T>  

```swift
self.word.valueDidChange = {
    self.label.text = self.word.value
    self.label.textColor = self.getRandomColor()
}
```

![Alt text](https://raw.githubusercontent.com/colatusso/Observable.Swift/master/Observable.gif)

## License
All this code is released under the MIT license.

