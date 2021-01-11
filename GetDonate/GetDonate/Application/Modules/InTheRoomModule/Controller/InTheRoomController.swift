//
//  InTheRoomController.swift
//  GetDonate
//
//  Created by Shiva Kr. on 08/01/21.
//

import UIKit

class InTheRoomController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    let inTheRoom = InTheRoomVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.configVM()
    }
}
//MARK: Configuration
extension InTheRoomController {
    private func configUI() {
        
    }
    private func configVM() {
        self.inTheRoom.config(item: self.collectionView)
    }
}
//MARK: Button Actions
extension InTheRoomController {
    @IBAction func clickOnBack() {
        POP()
    }
}
