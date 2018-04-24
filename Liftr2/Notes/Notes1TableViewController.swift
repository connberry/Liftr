//
//  Notes1TableViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 15/04/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//


import UIKit
import Firebase

class Notes1TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Declarations of Database and Added Exercise
    var addStep = [Workout]()
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
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        let test = addStep[indexPath.row]
        cell.textLabel?.text = test.workout
        cell.detailTextLabel?.text = test.date
        return cell
    }
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Database Reference
        ref = Database.database().reference()
        
        // Adds notes child
        handle = ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("completed workouts").observe(.childAdded, with: { (snapshot) in
            let results = snapshot.value as? [String : AnyObject]
            let workout = results?["workout"]
            let date = results?["date"]
            let data = Workout(workout: workout as! String?, date: date as! String?)
            self.addStep.append(data)
            self.tableView.reloadData()
        })
        
        
    }
    func getDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        // hours + min:  -\(calendar.component(.hour, from: date))-\(calendar.component(.minute, from: date))
        return "\(calendar.component(.year, from: date))-\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))"
        
    }
}
