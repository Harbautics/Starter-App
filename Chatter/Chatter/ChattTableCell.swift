//
//  ChattTable.swift
//  Chatter
//
//  Created by Troy Stacer on 9/23/18.
//  Copyright © 2018 Haurbautics. All rights reserved.
//

import Foundation
import UIKit
class ChattTableCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    override func awakeFromNib() { super.awakeFromNib()
        // Initialization code
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) { super.setSelected(selected, animated: animated)
            // Configure the view for the selected state
        }
        
}
