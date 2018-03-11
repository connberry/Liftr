//  ExercisesViewController.swift
//  Liftr2
//  Created by Connor Berry on 18/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit

var exercises = ["Chin Up",
                 "Press Up",
                 "Squat"]
var why = ["This challenging body-weight exercise strengthens a number of muscle groups, but the benefits you reap from dedication to chin-ups aren't just visual.",
           "Example example Example example Example example Example example ",
           "Example example Example example Example example Example example Example example"]

var step1 = ["1. Put your hands on the bar with your palms facing your body.",
             "1. Example example Example example Example example Example example ",
             "1. Example example Example example Example example Example example "]

var step2 = ["2. Raise your body until your chin is above the bar.",
             "2. Example example Example example Example example Example example",
             "2. Example example Example example Example example Example example"]

var step3 = ["3. Lower yourself back down. Using a slow, controlled motion, lower yourself until your arms are straight.",
             "3. Example example Example example Example example Example example",
             "3. Example example Example example Example example Example example"]

var muscleUsed = ["Muscles Used: Biceps, Shoulders, Latissimus Dorsi",
                  "Muscles Used: Example example Example example Example example",
                  "Muscles Used: Example example Example example Example example"]
var myIndex = 0

class ExercisesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = exercises[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        print(indexPath.row)
        cell.textLabel?.text = exercises[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "ExercisesSegue", sender: exercises[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { let guest = segue.destination as! Exercises2ViewController
        guest.heading = sender as! String
    }
    
    
    // Table declaration
    @IBOutlet weak var TableView: UITableView!
    
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Navigation bar gradient image
    let img = UIImage(named: "Navigation.png")
    navigationController?.navigationBar.barTintColor = UIColor(patternImage: img!)
        
    // Storyboard delegates and datasources
    TableView.delegate = self
    TableView.dataSource = self
}

}
