//
//  Player_TableViewCell.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 16/06/2021.
//

import UIKit

class Player_TableViewCell: UITableViewCell {
    

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblNickName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
