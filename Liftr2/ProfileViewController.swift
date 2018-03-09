//  ProfileViewController.swift
//  Liftr2
//  Created by Connor Berry on 10/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Navigation bar gradient image
    let img = UIImage(named: "Navigation.png")
    navigationController?.navigationBar.barTintColor = UIColor(patternImage: img!)
}
    
    // Sign user out of firebase
    @IBAction func SignOutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do { try firebaseAuth.signOut() } catch let signOutError as NSError { print ("Error signing out: %@", signOutError) }
        dismiss(animated: true, completion: nil)
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}
}
