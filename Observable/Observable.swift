import UIKit

enum BoolState {
    case AnyState
    case OnlyTrue
    case OnlyFalse
}

class Observable<T> {
    fileprivate var _switches: [ObservableSwitch] = []
    fileprivate var _value: T? = nil
    var valueDidChange:(()->())?
    
    var value: T {
        set {
            _value = newValue
            
            for s in self._switches {
                s.validate()
            }
            
            valueDidChange?()
        }
        get {
            return _value!
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func addSignal(_ signal: @escaping () -> Bool, toSwitch: ObservableSwitch) {
        for s in self._switches where s === toSwitch {
            s.addSignal(signal)
            
            return
        }
        
        toSwitch.addSignal(signal)
        self._switches.append(toSwitch)
    }
}

class ObservableTextField: UITextField, UITextFieldDelegate {
    fileprivate var _switches: [ObservableSwitch] = []
    var textDidChange:((_ text: String)->())?
    var count = 0
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        delegate = self
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        delegate = self
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        count = textField.text!.count
        
        textDidChange?(textField.text!)
        
        for s in self._switches {
            s.validate()
        }
    }
    
    func addSignal(_ signal: @escaping () -> Bool, toSwitch: ObservableSwitch) {
        for s in self._switches where s === toSwitch {
            s.addSignal(signal)
            
            return
        }
        
        toSwitch.addSignal(signal)
        self._switches.append(toSwitch)
    }
}

class ObservableTextView: UITextView, UITextViewDelegate {
    fileprivate var _switches: [ObservableSwitch] = []
    var textDidChange:((_ text: String) -> ())?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        for s in self._switches {
            s.validate()
        }
        
        textDidChange?(textView.text)
    }
    
    func addSignal(_ signal: @escaping () -> Bool, toSwitch: ObservableSwitch) {
        for s in self._switches where s === toSwitch {
            s.addSignal(signal)
            
            return
        }
        
        toSwitch.addSignal(signal)
        self._switches.append(toSwitch)
    }
}

class ObservableSwitch {
    fileprivate var signals: [() -> Bool] = []
    fileprivate var boolState: BoolState
    var action:((_ status: Bool)->())?
    
    init(_ boolState: BoolState) {
        self.boolState = boolState
    }
    
    fileprivate func addSignal(_ signal: @escaping () -> Bool) {
        self.signals.append(signal)
    }
    
    fileprivate func validate() {
        var result = true
        
        for check in signals {
            if (result && !check()) {
                result = false
                break
            }
        }
        
        if boolState == .AnyState {
            action?(result)
        }
        else if boolState == .OnlyTrue && result {
            action?(true)
        }
        else if boolState == .OnlyFalse && !result {
            action?(false)
        }
    }
}

