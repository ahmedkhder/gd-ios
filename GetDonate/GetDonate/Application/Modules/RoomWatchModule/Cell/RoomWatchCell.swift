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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
//MARK: Setup Data
extension RoomWatchCell {
    func setupData() {
        
    }
}
