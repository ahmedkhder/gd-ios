//
//  ChooseRoomController.swift
//  GetDonate
//
//  Created by Shiva Kr. on 27/01/21.
//

import UIKit

class ChooseRoomController: UIViewController {

    @IBOutlet var tblView: UITableView!
    
    private var chooseVM = ChooseVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configVM()
    }
}
extension ChooseRoomController {
    private func configVM() {
        self.chooseVM.config(item: tblView)
    }
}

extension ChooseRoomController {
    @IBAction func clickOnBack() {
        POP()
    }
}
