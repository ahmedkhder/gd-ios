//
//  InTheRoomCell.swift
//  GetDonate
//
//  Created by Shiva Kr. on 08/01/21.
//

import UIKit

protocol InTheRoomCellDelegate: class {
    func inTheCell(_ cell: InTheRoomCell, didSelectedAtThumb index: Int)
    func inTheCell(_ cell: InTheRoomCell, didSelectedAtHeart index: Int)
}
class InTheRoomCell: UICollectionViewCell, DequeuableRegistrable {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblUserID: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var viewDonate: UIView!
    @IBOutlet var viewBG: UIView!
    @IBOutlet var btnThumbUp: UIButton!
    @IBOutlet var btnHeart: UIButton!
    var delegate: InTheRoomCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBG.roundCorners([.bottomLeft, .bottomRight], radius: 20)
        viewDonate.roundCorners([.topLeft, .topRight], radius: 12)
    }
}
//MARK: Setup
extension InTheRoomCell {
    func setupData(index: Int, _ delegate: InTheRoomCellDelegate) {
        self.delegate = delegate
        self.btnThumbUp.tag = index
        self.btnHeart.tag = index
    }
}
//MARK: Button Action
extension InTheRoomCell {
    @IBAction func clickOnThumb(_ sender: UIButton) {
        self.delegate?.inTheCell(self, didSelectedAtThumb: sender.tag)
    }
    @IBAction func clickOnHeart(_ sender: UIButton) {
        self.delegate?.inTheCell(self, didSelectedAtHeart: sender.tag)
    }
}
