//
//  ViewController.swift
//  Wetter
//
//  Created by Sydney Handera on 27.01.15.
//  Copyright (c) 2015 Sydney Handera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var weather: Weather?
    
    @IBOutlet weak var viewRedHelper: UIView!
    @IBOutlet weak var btnReload: UIButton!
    @IBOutlet weak var lblGrad: UILabel!
    @IBOutlet weak var lblSunny: UILabel!
    @IBOutlet weak var lblStadt: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    
    @IBAction func refreshAction(sender: UIButton) {
        println("Button wurde gedrückt")
        fetchDataFromOpenweather()
    }
    
    
    func fetchDataFromOpenweather(){
        //http://api.openweathermap.org/data/2.5/weather?q=darmstadt
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=berlin")!
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
                                
                                self.weather =  Weather(city: cityName, country: country, sunrise: sunrise, sunset: sunset, humidity: humidity, pressure: pressure, status: description, tempMax: tempMax, tempMin: tempMin, temp: temp)
                                
                                dispatch_async(dispatch_get_main_queue(), {
                                    if let city = self.weather?.city {
                                        self.lblStadt.text = city
                                    }
                                    
                                    if let temp = self.weather?.temp{
                                        self.lblGrad.text = "\(temp)°"
                                    }
                                    
                                    if let humidity = self.weather?.humidity {
                                        self.lblHumidity.text = "\(humidity)"
                                    }
                                    
                                    if let pressure = self.weather?.pressure{
                                        self.lblPressure.text = "\(pressure)"
                                    }
                                    
                                    if let status = self.weather?.status{
                                        self.lblSunny.text = status
                                    }
                                    
                                });
                            
                                
                                
                            }
                        }
                        
                    }
                }
                
            }
            
            
            
        }).resume()
        
        /*
        
        {"coord":{"lon":8.65,"lat":49.87},"sys":{"type":3,"id":174267,"message":0.1942,"country":"DE","sunrise":1422342286,"sunset":1422375095},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"base":"cmc stations","main":{"temp":274.62,"humidity":90,"pressure":1020.791,"temp_min":274.05,"temp_max":276.05},"wind":{"speed":4.62,"deg":285},"rain":{"3h":0},"snow":{"3h":0},"clouds":{"all":36},"dt":1422345603,"id":2938913,"name":"Darmstadt","cod":200}
        
        
        */
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewRedHelper.backgroundColor = UIColor.whiteColor()
        fetchDataFromOpenweather()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

