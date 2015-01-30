//
//  DailyWeatherTableViewCell.swift
//  Wetter
//
//  Created by Sydney Handera on 30.01.15.
//  Copyright (c) 2015 Sydney Handera. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var lblGrad: UILabel!
    
    @IBOutlet weak var imgSunny: UIImageView!
    
    @IBOutlet weak var lblSnow: UILabel!
    
    @IBOutlet weak var lblRain: UILabel!
    
    @IBOutlet weak var lblUhr: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
