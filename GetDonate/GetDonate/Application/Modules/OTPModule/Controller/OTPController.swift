//
//  OTPController.swift
//  GetDonate
//
//  Created by Shiva Kr. on 09/01/21.
//

import UIKit

class OTPController: UIViewController {
    
    @IBOutlet weak var otpView: OTPView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnVerify: UIButton! {
        didSet { self.btnVerify.isEnabled(false) }
    }
    @IBOutlet weak var btnResend: UIButton!
    lazy var mobileNumebr: Observer<String> = {
        return Observer(.kEMPTY)
    }()
    var otpVM = OtpVM()
    var secondsRemaining: Int = 20
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarClear()
        //self.countDownFire()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //self.stopTimer()
    }
}
//MARK: Configuration
extension OTPController {
    func configUI() {
        self.hideKeyboardWhenTappedAround()
        self.otpView.getOTP = { otpString in
            self.otpVM.setOTP(Observer(otpString))
            self.btnVerify.isEnabled(otpString.length == 4)
        }
        self.mobileNumebr.bindAndFire {
            self.lblMessage.text = "We have send a OTP on your number\n\($0)"
        }
    }
    //MARK: Start Count Down Timer
    private func countDownFire() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            if self.secondsRemaining > 0 {
                let sec = self.timeFormatted(self.secondsRemaining)
                self.secondsRemaining -= 1
                self.btnResend.isEnabled(false)
                self.btnResend.titleLabel?.font = Font.Bold.of(size: 22)
                UIView.performWithoutAnimation {
                    self.btnResend.setTitle("\(sec)", for: .normal)
                    self.btnResend.layoutIfNeeded()
                }
            } else {
               // self.stopTimer()
                self.btnResend.isEnabled(true)
                self.btnResend.titleLabel?.font = Font.Bold.of(size: 18)
                self.btnResend.setTitle("Resend OTP", for: .normal)
            }
        }
    }
    private func stopTimer() {
        self.timer?.invalidate()
    }
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        return String(format: "00:%02d", seconds)
    }
}
//MARK: Buttons Action
extension OTPController {
    @IBAction func clickOnVerify(_ sender: UIButton) {
        let roomVC = RoomWatchController.instantiate()
        PUSH(roomVC)
    }
    @IBAction func clickOnResend(_ sender: UIButton) {
        let donateVC = DonationController.instantiate()
        self.PUSH(donateVC)
    }
    @IBAction func clickOnBack() {
        POP()
    }
    
}
