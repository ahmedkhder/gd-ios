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
    lazy var mobileNumber: Observer<String> = {
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
            otpString.length == 4 ? self.verifyOTP() : nil
        }
        self.mobileNumber.bindAndFire {
            self.lblMessage.text = "We have sent a OTP on your number\n\($0)"
            self.otpVM.mobileString = $0
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
    //MARK: Call API 
    private func verifyOTP() {
        self.btnVerify.indicator(isVisible: true)
        self.handleOTPResponse()
        self.otpVM.requestVerifyOTP()
    }
}
//MARK: Buttons Action
extension OTPController {
    @IBAction func clickOnVerify(_ sender: UIButton) {
        self.btnVerify.indicator(isVisible: true)
        self.handleOTPResponse()
        self.otpVM.requestVerifyOTP()
    }
    @IBAction func clickOnResend(_ sender: UIButton) {
        let donateVC = DonationController.instantiate()
        self.PUSH(donateVC)
    }
    @IBAction func clickOnBack() {
        POP()
    }
}
//MARK: ====> Hndle Response <====
extension OTPController {
    private func handleOTPResponse() {
        self.otpVM.onSuccess = {[weak self] response in
            guard let weakSelf = self else { return }
            MainQueue.async {
                weakSelf.btnVerify.indicator(isVisible: false)
            }
            switch response {
            case .success(result: let json):
                let _ = json
                MainQueue.async {
                    let roomVC = RoomWatchController.instantiate()
                    weakSelf.PUSH(roomVC)
                }
            case .failure(let error):
                switch error {
                case .network(string: let msg),
                     .parser(string: let msg), .custom(string: let msg):
                    weakSelf.showPopup(message: msg) {}
                default: break
                }
            }
        }
    }
}
