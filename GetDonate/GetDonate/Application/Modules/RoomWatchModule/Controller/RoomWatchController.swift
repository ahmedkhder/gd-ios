//
//  RoomWatchController.swift
//  GetDonate
//
//  Created by Shiva Kr. on 08/01/21.
//

import UIKit

class RoomWatchController: UIViewController {

    @IBOutlet var tblView: UITableView!
    let roomWatchVM = RoomWatchVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.configVM()
    }
}
//MARK: Configuration
extension RoomWatchController {
    func configUI() {
        self.navigationController?.navigationBarDefault()
    }
    func configVM() {
        self.roomWatchVM.config(item: tblView)
        self.roomWatchVM.selectedListener = {[weak self] (index, msg) in
            let inRommVC = InTheRoomController.instantiate()
            self?.PUSH(inRommVC)
        }
    }
}
//MARK: Button Ations
extension RoomWatchController {
    @IBAction func clickOnBack() {
        POP()
    }
}

