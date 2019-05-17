//
//  DaysWeatherTableViewCell.swift
//  SkyNow
//
//  Created by Fatimah Galhoum on 5/17/19.
//  Copyright © 2019 Fatimah Galhoum. All rights reserved.
//

import UIKit

class DaysWeatherTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
