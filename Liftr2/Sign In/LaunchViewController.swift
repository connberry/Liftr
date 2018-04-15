//
//  LaunchViewController.swift
//  
//
//  Created by Connor Berry on 07/04/2018.
//

import UIKit
import Firebase

class LaunchViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.image.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 0.35, animations: {() -> Void in
                self.image.transform = CGAffineTransform(scaleX: 30, y: 30)
            })
        })
        
        Timer.scheduledTimer(timeInterval: 1.05, target: self, selector: #selector(timelogged), userInfo: nil, repeats: false)
    }
    @objc func timelogged() {
        // Once signed in user goes straight to Profile
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "logged", sender: self)
        } else {
            self.performSegue(withIdentifier: "welcome", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    
    }

}
