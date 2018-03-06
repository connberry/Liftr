//  ExercisesViewController.swift
//  Liftr2
//  Created by Connor Berry on 18/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit

class ExercisesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Table declaration
    @IBOutlet weak var TableView: UITableView!
    
    //Exercise list declaration
    var exercises = ["Ab Roller", "Back Fly", "Back Fly with Leg Curl", "Biceps Curl", "Calf Raise", "Chest Fly", "Chest Press", "Chin-Up", "Close-Grip Chest Press", "Crossover Row", "Crunch", "Crunch with Leg Curl", "Decline Chest Fly", "Front Lunge", "High Leg Pull-In", "Hip Abduction", "Hyperextension", "Incline Chest Fly", "Incline Push Up", "Inclined Crunch with Feet Attached", "Jacknife Sit-Up", "Jumping Squat", "Jumping and Twisting Squat", "Kneeling Row", "Lateral Arm Pull", "Lateral Chest Fly", "Lateral Deltoid Raise", "Lateral Pulldown", "Lateral Pulldown with Squat", "Leg Curl", "Low Leg Pull-In", "Prone Back Fly", "Pull-Up", "Pulldown with Squat with Elbows Flexed", "Pullover", "Pullover with Crunch", "Pullover with Squat", "Pullover with Twisting Crunch", "Resisted Crunch", "Reverse Leg Curl", "Rotating Back Fly", "Row", "Row with Hyperextension", "Shoulder Extension", "Shoulder Press", "Side Plank", "Single Leg Pullover with Squat", "Single-Leg Squat", "Single-Leg Squat Kneeling", "Single-Leg Squat On Side", "Sit-Up with Cable", "Sit-Up with Feet Attached", "Squat", "Triceps Extension", "Trunk Rotation", "Twisting Squat", "Upright Row", "Upright Row with Hyperextension", "Upright Row with Leg Curl", "Wide Squat", "Wide-Grip Chest Press"]
    
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

    //Number of rows returns the var from excercise list declaration
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return exercises.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { let cell = UITableViewCell()
    cell.accessoryType = .disclosureIndicator
    print(indexPath.row)
        
    //Returns excercise list
    cell.textLabel?.text = exercises[indexPath.row]
    return cell
}
    // Segue to differient exercise view controllers
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { performSegue(withIdentifier: "ExercisesSegue", sender: exercises[indexPath.row]) }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { let guest = segue.destination as! Exercises2ViewController
    guest.heading = sender as! String
}
}
