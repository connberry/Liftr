//  LaunchViewController.swift
//  Liftr2
//  Created by Connor Berry on 07/04/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase

class LaunchViewController: UIViewController {
    
    // Liftr Logo
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    // Animates the Logo
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.image.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 0.35, animations: {() -> Void in
                self.image.transform = CGAffineTransform(scaleX: 30, y: 30)
            })
})
    // Timer to perform segue
        Timer.scheduledTimer(timeInterval: 1.05, target: self, selector: #selector(timelogged), userInfo: nil, repeats: false)
}
    @objc func timelogged() {
    // User either signs in or goes to welcome page dependent on log in status
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "logged", sender: self)
        } else {
            self.performSegue(withIdentifier: "welcome", sender: self)
        }
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
