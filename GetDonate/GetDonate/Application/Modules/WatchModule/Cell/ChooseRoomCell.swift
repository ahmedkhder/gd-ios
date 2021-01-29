//
//  ChooseRoomCell.swift
//  GetDonate
//
//  Created by Shiva Kr. on 29/01/21.
//

import UIKit

class ChooseRoomCell: UITableViewCell, DequeuableRegistrable {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblRoomName: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var lblAmount: UILabel!
    @IBOutlet var btnLock: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
