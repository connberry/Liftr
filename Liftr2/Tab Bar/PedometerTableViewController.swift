//
//  PedometerTableViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 10/04/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit
import Firebase
import NotificationBannerSwift


class PedometerTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = addStep[indexPath.row]
        cell.detailTextLabel?.text = getDate()
        return cell
    }
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Database Reference
        ref = Database.database().reference()
    
        // Adds notes child
        handle = ref?.child("user").child(Auth.auth().currentUser!.uid).child("pedometer").observe(.childAdded, with: { (snapshot) in
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
    // Adds checkmark functionality
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let myString1 = addStep[indexPath.row]
        let myInt1 = Int(myString1)
        if myInt1! > 0 && myInt1! < 1000 {
            let banner = NotificationBanner(title: "Not good... 😔", subtitle: "The daily recommended is 10,000! You've only hit under 10% of that...", style: .danger)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 1001 && myInt1! < 3000 {
            let banner = NotificationBanner(title: "Getting there 🏃‍♀️", subtitle: "The daily recommended is 10,000! You've hit 10-30% of that...", style: .danger)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 3001 && myInt1! < 4999 {
            let banner = NotificationBanner(title: "Getting there 🏃‍♀️", subtitle: "The daily recommended is 10,000! You've only hit 30-50% of that...", style: .warning)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 5000 && myInt1! < 6000 {
            let banner = NotificationBanner(title: "Half Way! 💪", subtitle: "Under 5000 left, You've got this!", style: .warning)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 6001 && myInt1! < 8000 {
            let banner = NotificationBanner(title: "Business end of your steps 📈", subtitle: "60-80% complete, not long now....", style: .success)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 8001 && myInt1! < 9999 {
            let banner = NotificationBanner(title: "You're awesome! 🙌", subtitle: "80-99% complete, you're so close you can taste the success", style: .success)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 10000 && myInt1! < 25000 {
            let banner = NotificationBanner(title: "YOU'VE DONE IT! 🎉", subtitle: "The daily recommended allowance is complete! But that doesn't mean you stop going right?", style: .success)
            banner.show(queuePosition: .front)
        }
    }
    }
