//
//  FetchDataHelper.swift
//  Wetter
//
//  Created by Sydney Handera on 30.01.15.
//  Copyright (c) 2015 Sydney Handera. All rights reserved.
//

import UIKit

class FetchDataHelper {
    func forecast(actionBlock:((WeahterForecastDataSource) -> Void)) {
        //api.openweathermap.org/data/2.5/forecast?lat=35&lon=139
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=49.52&lon=8.39")!
        let request = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) -> Void in
            
            if error != nil {
                println("fetchGanzerTag error \(error)")
                return
            }
            var errorPointer: NSError?
            let readingOptions = NSJSONReadingOptions.AllowFragments
            let parsedJSON: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: readingOptions, error: &errorPointer)
            //println("fetchGanzerTag \(parsedJSON)")
            
            if let openWeatherDailyDict = parsedJSON as? NSDictionary{
                
                
                if let listArray = openWeatherDailyDict["list"] as? NSArray{
                    println(listArray)
                    println(listArray.count)
                    var tmpArray:[WeatherForecast]=[]
                    for tmpItem in listArray{
                        
                        var tempRain:Double?
                        var tempSnow:Double?
                        var tempTemp:Double?
                        var tempDescription:String?
                        var tempDt:Int?
                        
                        if let item = tmpItem as? NSDictionary{
                            println("item: \(item)")
                            if let rainDict = item["rain"] as? NSDictionary{
                                println(rainDict)
                                let rainthreehours = rainDict["3h"] as? Double ?? 0.0
                                println(rainthreehours)
                                tempRain = rainthreehours
                            }                           /*
                            if let rainDict = openWeatherDailyDict["rain"] as? NSDictionary{
                            println(rainDict)
                            let rainthreehours = rainDict["3h"] as? Double ?? 0.0
                            println(rainthreehours)
                            }*/
                            
                            if let snowDict = item["snow"] as? NSDictionary{
                                println(snowDict)
                                let snowthreehours = snowDict["3h"] as? Double ?? 0.0
                                println(snowthreehours)
                                tempSnow = snowthreehours
                            }
                            
                            if let mainDict = item["main"] as? NSDictionary{
                                println(mainDict)
                                let temp = mainDict["temp"] as? Double ?? 0.0
                                println(temp)
                                tempTemp = temp
                                
                                
                            }
                            if let weatherArray = item["weather"] as? NSArray {
                                if let weatherDict = weatherArray[0] as? NSDictionary{
                                    println(weatherDict)
                                    let icon = weatherDict["description"] as? String ?? ""
                                    println(icon)
                                    tempDescription = icon
                                }
                                
                            }
                            if let dt = item["dt"] as? Int ?? 0 {
                                tempDt = dt
                            }
                            let weatherForecast = WeatherForecast(dt:tempDt!,rainThreeHours: tempRain, snowThreeHours: tempSnow, temp: tempTemp, descriptionIcon: tempDescription)
                            tmpArray.append(weatherForecast)
                        }
                    }
                    println(tmpArray.count)
                    
                    let weatherForecastDataSource = WeahterForecastDataSource(weather: tmpArray)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        actionBlock(weatherForecastDataSource)
                    })
                }
            }
        }).resume()
    }
    
    
    
    func day(actionBlock:((Weather) -> Void)) {
        //http://api.openweathermap.org/data/2.5/weather?q=darmstadt
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=darmstadt")!
        let request = NSURLRequest(URL: url)
        let config =  NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil {
                println(error)
                return
            }
            var errorPointer:NSError?
            let readingOptions = NSJSONReadingOptions.AllowFragments
            let parsedJSON:AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: readingOptions, error: &errorPointer)
            
            if let openWeatherDict = parsedJSON as? NSDictionary{
                println(openWeatherDict)
                let cityName = openWeatherDict["name"] as? String ?? "Keine Stadt gefunden"
                let dieBase = openWeatherDict["base"] as? String ?? ""
                let komischesDt = openWeatherDict["dt"] as? Double ?? 0.0
                let komischesId = openWeatherDict["id"] as? Double ?? 0.0
                
                println(dieBase)
                println(komischesDt)
                println(komischesId)
                
                if let mainDict = openWeatherDict["main"] as? NSDictionary{
                    println(mainDict)
                    let humidity = mainDict["humidity"] as? Double ?? 0.0
                    let pressure = mainDict["pressure"] as? Double ?? 0.0
                    let tempMax = mainDict["temp_max"] as? Double ?? 0.0
                    let tempMin = mainDict["temp_min"] as? Double ?? 0.0
                    let temp = mainDict["temp"] as? Double ?? 0.0
                    println(temp)
                    println(pressure)
                    println(humidity)
                    println(tempMax)
                    println(tempMin)
                    
                    if let sysDict = openWeatherDict["sys"] as? NSDictionary{
                        println(sysDict)
                        let country = sysDict["country"] as? String ?? ""
                        let sunrise = sysDict["sunrise"] as? Double ?? 0.0
                        let sunset = sysDict["sunset"] as? Double ?? 0.0
                        println("Land: \(country)")
                        println("sunrise: \(sunrise)")
                        println("sunset: \(sunset)")
                        
                        
                        if let weatherArray = openWeatherDict["weather"] as? NSArray {
                            if let weatherDict = weatherArray[0] as? NSDictionary{
                                let description = weatherDict["description"] as? String ?? ""
                                let main = weatherDict["main"] as? String ?? ""
                                
                                println(weatherDict)
                                println(description)
                                println(main)
                                
                                let weather =  Weather(city: cityName, country: country, sunrise: sunrise, sunset: sunset, humidity: humidity, pressure: pressure, status: description, tempMax: tempMax, tempMin: tempMin, temp: temp)
                                
                                
                                
                                dispatch_async(dispatch_get_main_queue(), {
                                    actionBlock(weather)
                                                                        
                                });
                            }
                        }
                    }
                }
            }
        }).resume()
    }
    
   
}
