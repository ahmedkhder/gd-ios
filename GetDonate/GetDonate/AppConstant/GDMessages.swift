//
//  Messages.swift
//  GetDonate
//
//  Created by JMD on 05/01/21.
//

import Foundation
import SDWebImage

extension String {
    static let LOGIN_INFO = "LoginInfo"
}

extension String {
    static let kEMPTY           = ""
    static let kNO_DATA         = "Data not found"
    static let kUNKOWN          = "Something went wrong, please try again."
    static let kOFFLINE         = "Internet connection appears to be offline.\nTry again later."
    static let kDATA_LOADING    = "Loading..."
    static let kPULL_TO_DOWN    = "Pull to down for refresh."
    static let kVALID_EMAIL     = "Incorrect mobile number"
    static let kLOGOUT          = "Are you sure you want to logout?"
    static let kENTER_OTP       = "Please enter OTP"
    static let kDIAL_CODE_EMPTY = "Please select your country dial code"
}

extension String {
    //MARK: Convert Url String to URL
    public var toUrl: URL? {
        guard !self.isEmpty else {
            return nil
        }
        return URL(string: self)
    }
}
//MARK: ImageVIew extensions
extension UIImageView {
    func setImageFrom(url: String?, onSuccess: ((UIImage) -> Void)? = nil) {
        if let thumbUrl = url, !thumbUrl.isEmpty {
            self.showImageLoader()
            self.sd_setImage(with: (thumbUrl.toUrl)) { (img, error, cache, url) in
                MainQueue.async {
                    self.hideImageLoader()
                    if img == nil{
                        let defaultImg = UIImage(named: "ic_biryani")
                        self.setImage(defaultImg)
                    } else {
                        self.setImage(img)
                    }
                    guard onSuccess != nil else { return }
                    onSuccess?(img ?? UIImage())
                }
            }
        } else {
            MainQueue.async {
                self.image = UIImage(named: "ic_biryani")
            }
        }
    }
}
extension NSLayoutConstraint {
    func updateConstant(_ constant: CGFloat, of vc: UIViewController) {
        UIView.animate(withDuration: .O3, animations: {
            self.constant = constant
            vc.view.layoutIfNeeded()
        }) { (isFinished) in
            if isFinished {
                
            }
        }
    }
}

//MARK: Int
extension Int {
    static let CODE_200 = 200 // Success
    static let CODE_400 = 400 //user not found
    static let CODE_404 = 404
}

