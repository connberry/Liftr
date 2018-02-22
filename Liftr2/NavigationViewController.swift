//
//  NavigationViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 22/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
     //let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gradientLayer.frame = self.navigationController!.navigationBar.bounds
        //gradientLayer.colors = [UIColor(red: 156/255.5, green: 102/255.5, blue: 211/255.5, alpha: 1.0).cgColor, UIColor(red: 249/255.5, green: 122/255.5, blue: 225/255.5, alpha: 1.0).cgColor]
       // gradientLayer.locations = [0.0, 1.0]
       // gradientLayer.startPoint = CGPoint (x: 0.0, y: 1.0)
      //  gradientLayer.endPoint = CGPoint (x: 1.0, y: 0.0)
      //  self.navigationController!.navigationBar.layer.insertSublayer(gradientLayer, at: 5)
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
