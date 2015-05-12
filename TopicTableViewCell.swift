//
//  TopicTableViewCell.swift
//  Prattle
//
//  Created by Rick Zemer on 5/12/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var topicLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
