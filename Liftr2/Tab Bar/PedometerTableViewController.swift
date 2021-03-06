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
    var addStep = [Steps]()
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
        let test = addStep[indexPath.row]
        cell.textLabel?.text = test.steps
        cell.detailTextLabel?.text = test.date
        return cell
    }
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Database Reference
        ref = Database.database().reference()
    
        // Adds notes child
        handle = ref?.child("user").child(Auth.auth().currentUser!.uid).child("pedometer").observe(.childAdded, with: { (snapshot) in
            let results = snapshot.value as? [String : AnyObject]
            let steps = results?["steps"]
            let date = results?["date"]
            let data = Steps(steps: steps as! String?, date: date as! String?)
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
    // Adds checkmark functionality
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let test = addStep[indexPath.row]
        let myString1 = test.steps
        let myInt1 = Int(myString1!)
        if myInt1! > 0 && myInt1! < 1000 {
            let banner = NotificationBanner(title: "Not good... 😔", subtitle: "Only 10% of the 10,000 recommended.", style: .danger)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 1001 && myInt1! < 3000 {
            let banner = NotificationBanner(title: "Getting there 🏃‍♀️", subtitle: "You've only hit 10-30% of the recommended!", style: .danger)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 3001 && myInt1! < 4999 {
            let banner = NotificationBanner(title: "Getting there 🏃‍♀️", subtitle: "You've hit 30-50% of recommened!", style: .warning)
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
            let banner = NotificationBanner(title: "YOU'VE DONE IT! 🎉", subtitle: "The daily recommended allowance is complete!", style: .success)
            banner.show(queuePosition: .front)
        }
    }
    }
