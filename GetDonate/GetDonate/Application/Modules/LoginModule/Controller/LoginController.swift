//
//  LoginControllerTableViewController.swift
//  GetDonate
//
//  Created by Shiva Kr. on 05/01/21.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet private var imgView: UIImageView!
    @IBOutlet private var txtFieldMobile: UITextField!
    @IBOutlet private var btnSignIn: UIButton! {
        didSet {self.btnSignIn.isEnabled(false) }
    }
    
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
}
//MARK: ===>Config<===
extension LoginController {
    private func configUI() {
        self.imgView.layer.cornerRadius = self.imgView.height / 2
        hideKeyboardWhenTappedAround()
        self.validationListener()
        self.txtFieldMobile.addTarget(self, action: #selector(handleTextFieldChange(textField:)), for: .editingChanged)
    }
    @objc func handleTextFieldChange(textField: UITextField) {
        if textField == txtFieldMobile {
            if let txt = textField.text {
                self.loginVM.mobileNo = Observer(txt)
            }
        }
    }
    //MARK: Listener
    fileprivate func validationListener() {
        self.loginVM.isValidListener = {[weak self] (isValid) in
            Log.print(isValid)
            guard let weakSelf = self else { return }
            weakSelf.btnSignIn.isEnabled(isValid)
        }
//        self.loginVM.arrayData.bind { array in
//            Log.print(array)
//        }
    }
}
//MARK: ====> Button Action <====
extension LoginController {
    @IBAction func clickOnBack() {
        POP()
    }
    @IBAction func clickOnSignin(_ sender: UIButton) {
        let otpView = OTPController.instantiate()
        self.PUSH(otpView)
    }
}
