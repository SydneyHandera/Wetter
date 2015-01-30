//
//  WeatherTable.swift
//  Wetter
//
//  Created by Dirk Handera on 29.01.15.
//  Copyright (c) 2015 Sydney Handera. All rights reserved.
//

import UIKit

class WeatherForecast{
    
    let temp: Double
    let rainThreeHours:Double
    let snowThreeHours:Double
    let descriptionIcon:String
    let date:NSDate
    
    init(dt:Int, rainThreeHours:Double?, snowThreeHours:Double?,temp:Double?, descriptionIcon:String?){
        var tmpDateString = dt ?? 1422975600 //"2015-02-03 15:00:00"
        self.date = NSDate(timeIntervalSince1970: NSTimeInterval(tmpDateString))
        if temp != nil {
            self.temp = temp! - 273.15
        } else {
            self.temp = 0
        }
        self.rainThreeHours = rainThreeHours ?? 0.0
        self.snowThreeHours = snowThreeHours ?? 0.0
        self.descriptionIcon = descriptionIcon ?? " "
        
    }
    
}
