import UIKit

class Observable<T> {
    private var _value: T? = nil
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
    var endPoint: ObservableSwitch?
    
    init(_ value: T) {
        self.value = value
    }
}

class ObservableTextField: UITextField, UITextFieldDelegate {
    var valueDidChange:((text: String)->())?
    var endPoint: ObservableSwitch?
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
                self.valueDidChange?(text: str)
            default:
                self.count = self.text!.characters.count + string.characters.count
                self.valueDidChange?(text: self.text! + string)
        }

        return true
    }
    
}

class ObservableTextView: UITextView, UITextViewDelegate {
    var valueDidChange:((text: String)->())?
    var endPoint: ObservableSwitch?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.delegate = self
    }
    
    func textViewDidChange(textView: UITextView) {
        self.valueDidChange?(text: textView.text)
    }
}

class ObservableSwitch {
    private var signals: [() -> Bool] = []
    var action:((status: Bool)->())?
    
    func addSignal(signal: () -> Bool) {
        self.signals.append(signal)
    }
    
    func validate() {
        for check in signals {
            if !check() {
                self.action?(status: false)
                return
            }
        }
        
        self.action?(status: true)
    }
}
