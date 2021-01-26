//
//  DonationController.swift
//  GetDonate
//
//  Created by Shiva Kr. on 13/01/21.
//

import UIKit

class DonationController: UITableViewController {

    @IBOutlet var txtFieldCardNo: UITextField!
    @IBOutlet var txtFieldMonth: UITextField!
    @IBOutlet var txtFieldCVC: UITextField!
    @IBOutlet var txtFieldName: UITextField!
    @IBOutlet var btnPay: UIButton! {
        didSet {
            self.btnPay.isEnabled(false)
        }
    }
    let maxNumberOfCharacters = 16
    var donationVM = DonationVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.navigationController?.navigationBarDefault()
    }
}
extension DonationController {
    func validationListener() {
        self.donationVM.isValidListener = {[weak self] (isValid) in
            guard let weakSelf = self else { return }
            weakSelf.btnPay.isEnabled(isValid)
        }
    }
    private func configUI() {
        hideKeyboardWhenTappedAround()
        self.validationListener()
        
    }
    private func setupTxtField(txtFields: [UITextField]) {
        let _ = txtFields.map {
            $0.addTarget(self, action: #selector(handleTextFieldChange(textField:)), for: .editingChanged)
        }
    }
    @objc func handleTextFieldChange(textField: UITextField) {
        switch textField {
        case txtFieldCardNo:
            self.donationVM.cardNo = Observer(textField.text ?? .kEMPTY)
        case txtFieldMonth:
            self.donationVM.expDate = Observer(textField.text ?? .kEMPTY)
        case txtFieldCVC:
            self.donationVM.cardNo = Observer(textField.text ?? .kEMPTY)
        case txtFieldName:
            self.donationVM.cardNo = Observer(textField.text ?? .kEMPTY)
        default:
            break
        }
    }
}
extension DonationController {
    @IBAction func clickOnPay(_ sender: UIButton) {
        
    }
    @IBAction func clickOnBack() {
        self.POP()
    }
}

extension DonationController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFieldCardNo {
        // only allow numerical characters
        guard string.compactMap({ Int(String($0)) }).count ==
            string.count else { return false }

        let text = textField.text ?? ""
        if string.count == 0 {
            textField.text = String(text.dropLast()).chunkFormatted()
        } else {
            let newText = String((text + string)
                .filter({ $0 != " " }).prefix(maxNumberOfCharacters))
            textField.text = newText.chunkFormatted()
        }
        return false
        } else if textField == txtFieldMonth {
            if range.length > 0 {
                  return true
                }
                if string == "" {
                  return false
                }
                if range.location > 4 {
                  return false
                }
                var originalText = textField.text
                let replacementText = string.replacingOccurrences(of: " ", with: "")

                //Verify entered text is a numeric value
                if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: replacementText)) {
                  return false
                }
                //Put / after 2 digit
                if range.location == 2 {
                  originalText?.append("/")
                  textField.text = originalText
                }
                return true
        } else if textField == txtFieldCVC {
            if range.location > 2 {
              return false
            }
        }
        return true
    }  
}
