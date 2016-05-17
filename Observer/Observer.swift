import Foundation

class Observable<T> {
    var _value: T? = nil
    var value: T {
        set {
            self._value = newValue
            self.valueDidChange?()
        }
        get {
            return self._value!
        }
    }
    
    var valueDidChange:(()->())?
    
    init(_ value: T) {
        self.value = value
    }
}

