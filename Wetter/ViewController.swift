//
//  ViewController.swift
//  Wetter
//
//  Created by Sydney Handera on 27.01.15.
//  Copyright (c) 2015 Sydney Handera. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var fetch: FetchDataHelper = FetchDataHelper()
    var weather: Weather?
    var weatherForecastDataSource: WeahterForecastDataSource?
    @IBOutlet weak var viewRedHelper: UIView!
    @IBOutlet weak var btnReload: UIButton!
    @IBOutlet weak var lblGrad: UILabel!
    @IBOutlet weak var lblSunny: UILabel!
    @IBOutlet weak var lblStadt: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var btnVorschau: UIButton!
    
    @IBOutlet weak var dailyTableView: UITableView!
    
    @IBOutlet weak var actGrad: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewRedHelper.backgroundColor = UIColor.whiteColor()
        self.getWeatherForToday()
    }
    
    @IBAction func refreshAction(sender: UIButton) {
        println("Button wurde gedrückt")
        self.getWeatherForToday()
    }

    @IBAction func vorschauAction (sender: UIButton){
        println("Vorschau wurde gedrückt")
        self.getWeatherForeCast()
    }
    
    func getWeatherForToday() {
        self.actGrad.hidden = false
        fetch.day({
            (weather) -> Void in
            self.updateGUI(weather)
        })
    }

    func updateGUI(weather:Weather) {
        self.weather = weather
        
        if let city = self.weather?.city {
            self.lblStadt.text = city
        }
        
        if let temp = self.weather?.temp{
            self.lblGrad.text = String(format: "%.1f °", temp)
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
        self.actGrad.hidden = true;
        
    }

    
    func getWeatherForeCast() {
        fetch.forecast({
            (foreCastWeather) -> Void in
            self.weatherForecastDataSource = foreCastWeather
            self.dailyTableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = weatherForecastDataSource?.ganzesWetter.count ?? 0
        return count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("weatherForecastCellID") as DailyWeatherTableViewCell
        let weatherData = weatherForecastDataSource?.ganzesWetter
        if let weatherForecast:WeatherForecast = weatherData?[indexPath.row] {
            cell.configureCell(weatherForecast)
        }
 
        return cell
    }

}


