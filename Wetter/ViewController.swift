//
//  ViewController.swift
//  Wetter
//
//  Created by Dirk Handera on 27.01.15.
//  Copyright (c) 2015 Sydney Handera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblReload: UIButton!
    @IBOutlet weak var lblGrad: UILabel!
    @IBOutlet weak var lblSunny: UILabel!
    @IBOutlet weak var lblStadt: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPressure: UILabel!

    @IBAction func refreshAction(sender: UIButton) {
        println("Button wurde gedrückt")
        
        
        //http://api.openweathermap.org/data/2.5/weather?q=darmstadt
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=darmstadt")!
        let request = NSURLRequest(URL: url)
        let config =  NSURLSessionConfiguration.defaultSessionConfiguration()
        
        
        let session = NSURLSession(configuration: config)
        session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) -> Void in
            
            println(data)
            println(response)
            println(error)
            
        }).resume()
       
/*

        {"coord":{"lon":8.65,"lat":49.87},"sys":{"type":3,"id":174267,"message":0.1942,"country":"DE","sunrise":1422342286,"sunset":1422375095},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"base":"cmc stations","main":{"temp":274.62,"humidity":90,"pressure":1020.791,"temp_min":274.05,"temp_max":276.05},"wind":{"speed":4.62,"deg":285},"rain":{"3h":0},"snow":{"3h":0},"clouds":{"all":36},"dt":1422345603,"id":2938913,"name":"Darmstadt","cod":200}

        
*/
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

