//
//  WorkoutsViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 23/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit

class WorkoutsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "Navigation Bar.png")
        navigationController?.navigationBar.barTintColor = UIColor(patternImage: img!)

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
