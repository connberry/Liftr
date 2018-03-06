//  Exercises2ViewController.swift
//  Liftr2
//  Created by Connor Berry on 18/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit

class Exercises2ViewController: UIViewController {
    
    // Declaration to change heading to specific exercise
    @IBOutlet weak var Exercises: UINavigationItem!
    var heading = ""
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
     
    // Navigation bar gradient image
    let img = UIImage(named: "Navigation.png")
    navigationController?.navigationBar.barTintColor = UIColor(patternImage: img!)
    
    // Title of view controller equals exercise selection
    Exercises.title = heading
}
}
