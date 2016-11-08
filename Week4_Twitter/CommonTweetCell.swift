//
//  CommonTweetCell.swift
//  Week4_Twitter
//
//  Created by Phillip Pang on 11/7/16.
//  Copyright © 2016 Phillip Pang. All rights reserved.
//

import UIKit

class CommonTweetCell: UITableViewCell {
    
    
    @IBOutlet weak var gTextLabel: UILabel!
    @IBOutlet weak var gImageView: UIImageView!
    @IBOutlet weak var gUserLabel: UILabel!
    @IBOutlet weak var gCreateTimeLabel: UILabel!
    
    var tweet: Tweet?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
