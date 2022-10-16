//
//  PostCell.swift
//  Parstagram
//
//  Created by Weixin Yang on 10/16/22.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var photoview: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
