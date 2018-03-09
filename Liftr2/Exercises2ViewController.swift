//  Exercises2ViewController.swift
//  Liftr2
//  Created by Connor Berry on 18/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit

class Exercises2ViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    // Declaration to change heading to specific exercise
    @IBOutlet weak var Exercises: UINavigationItem!
    var heading = ""
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = exercises[myIndex]
        descLabel.text = step1[myIndex]
        exerciseImage.image = UIImage(named: exercises[myIndex] + ".jpg")
     
    // Navigation bar gradient image
    let img = UIImage(named: "Navigation.png")
    navigationController?.navigationBar.barTintColor = UIColor(patternImage: img!)
    
    // Title of view controller equals exercise selection
    Exercises.title = heading
}
}
