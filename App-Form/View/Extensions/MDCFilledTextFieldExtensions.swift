//
//  MDCFilledTextFieldExtensions.swift
//  App-Form
//
//  Created by José Manuel De Jesús Martínez on 09/02/24.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextControls_FilledTextFields

extension MDCFilledTextField {
    convenience init(labelTitle: String? = nil, placeholder: String, colorBorder: UIColor = .link, typeKeyboard: UIKeyboardType = UIKeyboardType.asciiCapable){
        self.init(frame: .zero)
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7372470498, green: 0.730694592, blue: 0.7404944301, alpha: 1) ])
        self.placeholder = placeholder
        self.backgroundColor = colorView
        self.addDoneButtonOnKeyBoard()
        
        self.setUnderlineColor(.label, for: .normal)
        self.setUnderlineColor(colorBorder, for: .editing)
        self.setUnderlineColor(.lightGray, for: .disabled)
        
        self.setTextColor(.label, for: .normal)
        self.setTextColor(.label, for: .editing)
        self.setTextColor(.lightGray, for: .disabled)
        
        self.setFilledBackgroundColor(colorView!, for: .editing)
        self.setFilledBackgroundColor(colorView!, for: .normal)
        
        self.setNormalLabelColor(.lightGray, for: .normal)
        
        if let labelTitle = labelTitle {
            self.label.text = labelTitle
            self.setFloatingLabelColor(.link, for: .editing)
            self.setFloatingLabelColor(.label, for: .normal)
        }
        
        self.keyboardType = typeKeyboard
    }
    
    func setError(textError: String){
        self.setUnderlineColor(.systemRed, for: .normal)
        self.setUnderlineColor(.systemRed, for: .editing)
        self.setUnderlineColor(.systemRed, for: .disabled)
        self.leadingAssistiveLabel.isHidden = false
        self.leadingAssistiveLabel.text = textError
        self.setLeadingAssistiveLabelColor(.systemRed, for: .normal)
        self.setLeadingAssistiveLabelColor(.systemRed, for: .editing)
        self.setFloatingLabelColor(.systemRed, for: .normal)
        self.setFloatingLabelColor(.systemRed, for: .editing)
    }
    
    func setOk(){
        self.setUnderlineColor(.label, for: .normal)
        self.setUnderlineColor(.link, for: .editing)
        self.setUnderlineColor(.lightGray, for: .disabled)
        self.label.textColor = .label
        self.leadingAssistiveLabel.isHidden = true
        self.leadingAssistiveLabel.text = ""
        self.setLeadingAssistiveLabelColor(.link, for: .editing)
        self.setLeadingAssistiveLabelColor(.label, for: .normal)
        self.setFloatingLabelColor(.label, for: .normal)
        self.setFloatingLabelColor(.link, for: .editing)
    }
    
    func addDoneButtonOnKeyBoard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: TextStringsApp.ready, style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
