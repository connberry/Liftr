//
//  Exercises2ViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 18/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit

class Exercises2ViewController: UIViewController {


    @IBOutlet weak var Exercises: UINavigationItem!
    
    var heading = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "Navigation.png")
        navigationController?.navigationBar.barTintColor = UIColor(patternImage: img!)
        
        Exercises.title = heading
        // Do any additional setup after loading the view.
    }
    


}
