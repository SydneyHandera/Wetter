//
//  WholeDay.swift
//  Wetter
//
//  Created by Sydney Handera on 29.01.15.
//  Copyright (c) 2015 Sydney Handera. All rights reserved.
//

import UIKit

class WeahterForecastDataSource {
    var ganzesWetter:[WeatherForecast]
    
    
    init (weather: [WeatherForecast]){
        self.ganzesWetter = weather
    }
}