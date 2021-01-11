//
//  OTPView.swift
//  OTPtextField
//
//  Created by Shiva Kr. on 08/01/21.
//
//

import UIKit

class OTPView: UIStackView {

    private var textFieldArray = [OTPTextField]()
    var numberOfOTPdigit = 4
    var getOTP:((String)->())? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setTextFields()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
        setTextFields()
    }
    //MARK: Setup StackView
    private func setupStackView() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.distribution = .fillEqually
        self.spacing = 8
    }
    //MARK: Setup TextField
    private func setTextFields() {
        for i in 0..<numberOfOTPdigit {
            let field = OTPTextField()
            textFieldArray.append(field)
            addArrangedSubview(field)
            field.delegate = self
            field.backgroundColor = .white
            field.textAlignment = .center
            field.layer.cornerRadius = 3
            field.layer.shadowColor = UIColor.black.cgColor
            field.tintColor = .darkGray
            field.font = UIFont.boldSystemFont(ofSize: 22)
            i != 0 ? (field.previousTextField = textFieldArray[i-1]) : ()
            i != 0 ? (textFieldArray[i-1].nextTextFiled = textFieldArray[i]) : ()
        }
    }
}
//MARK: TextField Delegate
extension OTPView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let field = textField as? OTPTextField else {
            return true
        }
        if !string.isEmpty {
            field.text = string
            field.resignFirstResponder()
            field.nextTextFiled?.becomeFirstResponder()
            self.calculateOTP()
            return true
        } else {
            field.text = ""
        }
        self.calculateOTP()
        return true
    }
    private func calculateOTP() {
        var otp = ""
        let _ = textFieldArray.map { (txtField) in
            otp += txtField.text ?? ""
        }
        self.getOTP?(otp)
    }
}
//MARK: TextField Class
class OTPTextField: UITextField {
    var previousTextField: UITextField?
    var nextTextFiled: UITextField?
    
    override func deleteBackward() {
        text = ""
        previousTextField?.becomeFirstResponder()
    }
}
