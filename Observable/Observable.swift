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
    
    init(_ value: T) {
        self.value = value
    }
}

class ObservableTextField: UITextField, UITextFieldDelegate {
    var valueDidChange:((text: String)->())?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.delegate = self
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        switch string {
            case "":
                // backspace 
                let str = self.text!.substringToIndex(self.text!.endIndex.predecessor())
                self.valueDidChange?(text: str)
            default:
                self.valueDidChange?(text: self.text! + string)
        }

        return true
    }
}

class ObservableTextView: UITextView, UITextViewDelegate {
    var valueDidChange:((text: String)->())?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.delegate = self
    }
    
    func textViewDidChange(textView: UITextView) {
        self.valueDidChange?(text: textView.text)
    }
}
