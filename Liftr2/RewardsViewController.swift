//  RewardsViewController.swift
//  Liftr2
//  Created by Connor Berry on 07/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import FirebaseDatabase
import Firebase

class RewardsViewController: UIViewController {
    
    
    @IBOutlet weak var goldRewardLabel: UILabel!
    @IBOutlet weak var silverRewardLabel: UILabel!
    @IBOutlet weak var bronzeRewardLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*
         Pulls the data from the online databse and displays it
         in the empty slots to show the user how they are doing
         */
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("user").child(userID!).child("rewards").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let gold = value?["gold reward"] as? Int ?? 0
            let silver = value?["silver reward"] as? Int ?? 0
            let bronze = value?["bronze reward"] as? Int ?? 0
            let total = (bronze + silver + gold)
            // ...
        
            self.goldRewardLabel.text = ("Gold 🥇: \(gold)")
            self.silverRewardLabel.text =  ("Silver 🥈: \(silver)")
            self.bronzeRewardLabel.text = ("Bronze 🥉: \(bronze)")
            self.totalLabel.text = ("Daily Rewards 🏆: \(total)")
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
}
