//
//  Notes3TableViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 15/04/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit
import Firebase

class Notes3TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Declarations of Database and Added Exercise
    var addStep:[String] = []
    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    
    // Storyboard connections
    @IBOutlet weak var tableView: UITableView!
    
    // Table returns number of exercises
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addStep.count
    }
    //     Cell textLabel equals exercise entered
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = addStep[indexPath.row]
        return cell
    }
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser?.uid != nil {
            Database.database().reference().child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes names").observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dict["notes 3"] as? String
                    
                }
            })
        }
        
        
        // Database Reference
        ref = Database.database().reference()
        
        // Adds notes child
        handle = ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 3").child("completed workouts").observe(.childAdded, with: { (snapshot) in
            if let steps = snapshot.value as? String
            {
                
                self.addStep.append(steps)
                self.tableView.reloadData()
            }
        })
        
    }
    func getDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        // hours + min:  -\(calendar.component(.hour, from: date))-\(calendar.component(.minute, from: date))
        return "\(calendar.component(.year, from: date))-\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))"
        
    }
}
