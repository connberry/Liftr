//  TabBarViewController.swift
//  Liftr2
//  Created by Connor Berry on 22/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit

class TabBarViewController: UITabBarController {
    
    // Tab Bar gradient layer beginning
    let gradientLayer = CAGradientLayer()
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()

    // Gradient colour, direction and frame
    gradientLayer.colors = [UIColor(red: 156/255.5, green: 102/255.5, blue: 211/255.5, alpha: 1.0).cgColor, UIColor(red: 249/255.5, green: 122/255.5, blue: 225/255.5, alpha: 1.0).cgColor]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    gradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    
    // Insert the tab bar layer
    self.tabBar.layer.insertSublayer(gradientLayer, at: 0)
    }
}
