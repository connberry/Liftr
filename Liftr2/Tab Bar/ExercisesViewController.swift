//  ExercisesViewController.swift
//  Liftr2
//  Created by Connor Berry on 18/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase
import NotificationBannerSwift

// Variables for preloaded exercise information
var exercises = ["Ab Roller",
                 "Arnold Dumbbell Press",
                 "Back Extension",
                 "Bench Press",
                 "Bench Press (Dumbbell)",
                 "Bent Over Row",
                 "Bicep Curl",
                 "Box Squat",
                 "Bulgarian Split Squat",
                 "Cable Tucks",
                 "Cable Crossover",
                 "Calf Raise",
                 "Chest Fly",
                 "Chest Press",
                 "Chin Up",
                 "Clean",
                 "Clean and Jerk",
                 "Cross Leg Crunch",
                 "Crunch",
                 "Deadlift",
                 "Decline Crunch",
                 "Diamond Press Up",
                 "Exercise Ball Crunch",
                 "Front Raise",
                 "Good Morning",
                 "Press Up",
                 "Squat"]

var experience = ["Newbie 🤷‍♂️", "Skilled 👀", "Expert 💪", "Newbie 🤷‍♂️", "Skilled 👀", "Expert 💪", "Newbie 🤷‍♂️", "Skilled 👀", "Expert 💪", "Newbie 🤷‍♂️", "Skilled 👀", "Expert 💪", "Newbie 🤷‍♂️", "Skilled 👀", "Expert 💪", "Newbie 🤷‍♂️", "Skilled 👀", "Expert 💪", "Newbie 🤷‍♂️", "Skilled 👀", "Expert 💪", "Newbie 🤷‍♂️", "Skilled 👀", "Expert 💪", "Newbie 🤷‍♂️", "Skilled 👀", "Expert 💪", "Newbie 🤷‍♂️"]
var why = [
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "This challenging exercise strengthens a number of muscle groups, but the benefits aren't just visual.",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example",
    "Example"]

var step1 = [
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Put your hands on the bar with your palms facing your body.",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example",
    "1. Example"]

var step2 = [
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Raise your body until your chin is above the bar.",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example",
    "2. Example"]

var step3 = [
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Lower yourself back down. Using a slow, controlled motion, lower yourself until your arms are straight.",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example",
    "3. Example"]

var muscleUsed = [
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Biceps, Shoulders, Latissimus Dorsi",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example",
    "Muscles Used: Example"]
var myIndex = 0

class ExercisesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    
    // Return number of exercises
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    // Cell properties including exercise name
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = exercises[indexPath.row]
        cell.detailTextLabel?.text = experience[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        print(indexPath.row)
        return cell
    }
    
    // When user selects row, segue to appropriate view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    myIndex = indexPath.row
        let pasteboard = UIPasteboard.general
        pasteboard.string = exercises[indexPath.row]
    performSegue(withIdentifier: "ExercisesSegue", sender: exercises[indexPath.row])
    }
    // Let the heading be that of the name of the exercise selected
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { let guest = segue.destination as! Exercises2ViewController
        guest.heading = sender as! String
    }
    
    // Table declaration
    @IBOutlet weak var TableView: UITableView!
    
    
    @IBAction func Exp(_ sender: Any) {
        
ref.child("user").child(Auth.auth().currentUser!.uid).child("user details").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
    let value = snapshot.value as? NSDictionary
    let experience = value?["experience"] as? String ?? ""
    let banner = NotificationBanner(title: "\(experience)", subtitle: "As a \(experience), it's suggested you select the exercises that match your experience!", style: .success)
    banner.show(queuePosition: .front)
}) { (error) in
    print(error.localizedDescription)
        }
    }
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        
    // Storyboard delegates and datasources
    TableView.delegate = self
    TableView.dataSource = self
    }
    
    @IBAction func Change(_ sender: AnyObject) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        let ChangeVC = UIStoryboard(name: "Tab Bar", bundle: nil).instantiateViewController(withIdentifier: "Change") as! ChangeExperienceViewController
        self.addChildViewController(ChangeVC)
        self.view.addSubview(ChangeVC.view)
        ChangeVC.didMove(toParentViewController: self)
    // Change experience button tapped
        
    }
    


}
