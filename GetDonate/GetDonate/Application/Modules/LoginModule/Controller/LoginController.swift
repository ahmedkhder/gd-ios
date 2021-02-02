//
//  LoginControllerTableViewController.swift
//  GetDonate
//
//  Created by Shiva Kr. on 05/01/21.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet private var txtCCode: SKTextField!
    @IBOutlet private var txtFieldMobile: SKTextField!
    @IBOutlet private var btnSignIn: UIButton! {
        didSet {self.btnSignIn.isEnabled(false) }
    }
    let maxNumberOfCharacters = 16
    let loginVM = LoginVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarClear()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.txtCCode.layer.addBorder(edge: .right, color: Color.txtFieldBorderColor)
    }
}
//MARK: ===>Config<===
extension LoginController {
    private func configUI() {
        self.hideKeyboardWhenTappedAround()
        self.validationListener()
        let _ = [txtFieldMobile, txtCCode].map {
            $0.addTarget(self, action: #selector(handleTextFieldChange(textField:)), for: .editingChanged)
        }
    }
    @objc func handleTextFieldChange(textField: UITextField) {
        switch textField {
        case txtFieldMobile:
            if let txt = textField.text {
                self.loginVM.mobileNo = Observer(txt)
            }
        case txtCCode:
            if let txt = textField.text {
                self.loginVM.countryCode = Observer(txt)
            }
        default:
            break
        }
    }
    //MARK: Listener
    fileprivate func validationListener() {
        self.loginVM.isValidListener = {[weak self] (isValid) in
            guard let weakSelf = self else { return }
            weakSelf.btnSignIn.isEnabled(isValid)
        }
//        self.loginVM.arrayData.bind { array in
//            Log.print(array)
//        }
    }
}
//MARK: Handle API Response
extension LoginController {
    private func handleLoginResponse() {
        self.loginVM.onSuccess = { response in
            MainQueue.async {
                self.btnSignIn.indicator(isVisible: false)
            }
            switch response {
            case .success(result: let json):
                let _ = json
                MainQueue.async {
                    let otpView = OTPController.instantiate()
                    otpView.mobileNumebr = Observer(self.txtFieldMobile.text!)
                    self.PUSH(otpView)
                }
            case .failure(let error):
                switch error {
                case .network(string: let msg),
                     .parser(string: let msg), .custom(string: let msg):
                    self.showPopup(message: msg) {}
                default: break
                }
            }
        }
    }
}
//MARK: ====> Button Action <====
extension LoginController {
    @IBAction func clickOnBack() {
        POP()
    }
    @IBAction func clickOnSignin(_ sender: UIButton) {
        self.handleLoginResponse()
        self.btnSignIn.indicator(isVisible: true)
        self.loginVM.requestLogin()
    }
    @IBAction func clickOnDialCode(_ sender: UIButton) {
        let dialVC = DialCountriesController {[weak self] (country) in
            guard let weakSelf = self else { return }
            weakSelf.loginVM.countryCode = Observer(country.dialCode!)
            weakSelf.txtCCode.text = country.dialCode
        }
        dialVC.show(vc: self)
    }
}
//MARK: Validate TextField
extension LoginController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.txtFieldMobile.verifyFields(shouldChangeCharactersIn: range, replacementString: string, vType: .phoneNumber)
    }
}
