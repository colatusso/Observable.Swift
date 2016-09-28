import UIKit

class Observable<T> {
    var valueDidChange:(()->())?
    fileprivate var _switch: ObservableSwitch?
    fileprivate var _value: T? = nil
    
    var value: T {
        set {
            _value = newValue
            _switch?.validate()
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
        self._switch = toSwitch
        self._switch?.addSignal(signal)
    }
}

class ObservableTextField: UITextField, UITextFieldDelegate {
    var textDidChange:((_ text: String)->())?
    fileprivate var _switch: ObservableSwitch?
    var count = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch string {
            case "":
                // backspace
                let str = text!.substring(to: text!.characters.index(before: text!.endIndex))
                count = str.characters.count
                textDidChange?(str)
            default:
                count = text!.characters.count + string.characters.count
                textDidChange?(text! + string)
        }
        
        _switch?.validate()

        return true
    }
    
    func addSignal(_ signal: @escaping () -> Bool, toSwitch: ObservableSwitch) {
        self._switch = toSwitch
        self._switch?.addSignal(signal)
    }
}

class ObservableTextView: UITextView, UITextViewDelegate {
    var textDidChange:((_ text: String) -> ())?
    fileprivate var _switch: ObservableSwitch?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        _switch?.validate()
        textDidChange?(textView.text)
    }
    
    func addSignal(_ signal: @escaping () -> Bool, toSwitch: ObservableSwitch) {
        self._switch = toSwitch
        self._switch?.addSignal(signal)
    }
}

class ObservableSwitch {
    fileprivate var signals: [() -> Bool] = []
    var action:((_ status: Bool)->())?
    
    fileprivate func addSignal(_ signal: @escaping () -> Bool) {
        self.signals.append(signal)
    }
    
    fileprivate func validate() {
        for check in signals {
            if !check() {
                action?(false)
                return
            }
        }
        
        action?(true)
    }
}
