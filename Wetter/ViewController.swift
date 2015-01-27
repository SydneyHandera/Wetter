//
//  ViewController.swift
//  Wetter
//
//  Created by Dirk Handera on 27.01.15.
//  Copyright (c) 2015 Sydney Handera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func refreshAction(sender: UIButton) {
        print("Button wurde gedrückt")
    }
    @IBOutlet weak var lblReload: UIButton!
    @IBOutlet weak var lblGrad: UILabel!
    @IBOutlet weak var lblSunny: UILabel!
    @IBOutlet weak var lblStadt: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

