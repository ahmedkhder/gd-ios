//
//  OTPController.swift
//  GetDonate
//
//  Created by Shiva Kr. on 09/01/21.
//

import UIKit

class OTPController: UIViewController {
    
    @IBOutlet weak var otpView: OTPView!
    @IBOutlet weak var btnVerify: UIButton! {
        didSet {
            self.btnVerify.isEnabled(false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.otpView.getOTP = { otpString in
            self.btnVerify.isEnabled(otpString.length == 4)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarClear()
    }
}
extension OTPController {
    @IBAction func clickOnVerify(_ sender: UIButton) {
        let roomVC = RoomWatchController.instantiate()
        PUSH(roomVC)
    }
    @IBAction func clickOnResend(_ sender: UIButton) {
        
    }
    @IBAction func clickOnBack() {
        POP()
    }
}
