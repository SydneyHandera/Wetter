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
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(weatherForecast:WeatherForecast) {
        lblGrad.text = String(format: "%.1f °C", weatherForecast.temp)
        lblRain.text = "\(weatherForecast.rainThreeHours)h"
        lblSnow.text = "\(weatherForecast.snowThreeHours)h"
        
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:00"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        
        let formattedDate = dateFormatter.stringFromDate(weatherForecast.date)
        lblUhr.text = formattedDate
    }
}
