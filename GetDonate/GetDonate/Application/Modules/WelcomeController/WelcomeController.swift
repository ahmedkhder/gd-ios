//
//  WelcomeController.swift
//  GetDonate
//
//  Created by Shiva Kr. on 07/01/21.
//

import UIKit

class WelcomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarClear()
    }
}
//MARK: Button Action
extension WelcomeController {
    @IBAction func clickOnWatch() {
        let cooseRoomVC = ChooseRoomController.instantiate()
        PUSH(cooseRoomVC)
    }
    @IBAction func clickOnGo() {
        let loginVC = LoginController.instantiate()
        PUSH(loginVC)
    }
}
