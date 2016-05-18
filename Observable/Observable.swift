import UIKit

class Observable<T> {
    var valueDidChange:(()->())?
    private var _switch: ObservableSwitch?
    private var _value: T? = nil
    
    var value: T {
        set {
            self._value = newValue
            self._switch?.validate()
            self.valueDidChange?()
        }
        get {
            return self._value!
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func addSignal(signal: () -> Bool, toSwitch: ObservableSwitch) {
        self._switch = toSwitch
        self._switch?.addSignal(signal)
    }
}

class ObservableTextField: UITextField, UITextFieldDelegate {
    var textDidChange:((text: String)->())?
    private var _switch: ObservableSwitch?
    var count = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.delegate = self
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        switch string {
            case "":
                // backspace
                let str = self.text!.substringToIndex(self.text!.endIndex.predecessor())
                self.count = str.characters.count
                self.textDidChange?(text: str)
            default:
                self.count = self.text!.characters.count + string.characters.count
                self.textDidChange?(text: self.text! + string)
        }
        
        self._switch?.validate()

        return true
    }
    
    func addSignal(signal: () -> Bool, toSwitch: ObservableSwitch) {
        self._switch = toSwitch
        self._switch?.addSignal(signal)
    }
}

class ObservableTextView: UITextView, UITextViewDelegate {
    var textDidChange:((text: String)->())?
    private var _switch: ObservableSwitch?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.delegate = self
    }
    
    func textViewDidChange(textView: UITextView) {
        self._switch?.validate()
        self.textDidChange?(text: textView.text)
    }
    
    func addSignal(signal: () -> Bool, toSwitch: ObservableSwitch) {
        self._switch = toSwitch
        self._switch?.addSignal(signal)
    }
}

class ObservableSwitch {
    private var signals: [() -> Bool] = []
    var action:((status: Bool)->())?
    
    private func addSignal(signal: () -> Bool) {
        self.signals.append(signal)
    }
    
    private func validate() {
        for check in signals {
            if !check() {
                self.action?(status: false)
                return
            }
        }
        
        self.action?(status: true)
    }
}
