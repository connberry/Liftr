//  ProfileViewController.swift
//  Liftr2
//  Created by Connor Berry on 10/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit

class ProfileViewController: UIViewController {
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Navigation bar gradient image
    let img = UIImage(named: "Navigation.png")
    navigationController?.navigationBar.barTintColor = UIColor(patternImage: img!)
}
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}
}
