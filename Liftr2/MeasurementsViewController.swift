//  WorkoutsViewController.swift
//  Liftr2
//  Created by Connor Berry on 23/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit

class MeasurementsViewController: UIViewController {

    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Navigation bar gradient image
    let img = UIImage(named: "Navigation.png")
    navigationController?.navigationBar.barTintColor = UIColor(patternImage: img!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
}
