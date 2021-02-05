//
//  RoomWatchCell.swift
//  GetDonate
//
//  Created by Shiva Kr. on 08/01/21.
//

import UIKit

class RoomWatchCell: UITableViewCell, DequeuableRegistrable {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var btnThumb: UIButton!
    weak var delegate: CellCommonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
//MARK: Setup Data
extension RoomWatchCell {
    func setupData(_ model: Any, delegate: CellCommonDelegate, for index: Int) {
        self.delegate = delegate
        self.btnHeart.tag = index
        self.btnThumb.tag = index
    }
}
//Button Actions
extension RoomWatchCell {
    @IBAction func clickOnHeart(_ sender: UIButton) {
        self.delegate?.tableViewCell(self, didPressOn: .kHeart, tag: sender.tag)
    }
    @IBAction func clickOnThumbs(_ sender: UIButton) {
        self.delegate?.tableViewCell(self, didPressOn: .kThumb, tag: sender.tag)
    }
}
