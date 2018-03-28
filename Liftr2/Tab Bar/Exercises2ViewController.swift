//  Exercises2ViewController.swift
//  Liftr2
//  Created by Connor Berry on 18/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit

class Exercises2ViewController: UIViewController {
    
    // Storyboard connections
    @IBOutlet weak var Imp: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var No1: UILabel!
    @IBOutlet weak var No2: UILabel!
    @IBOutlet weak var No3: UILabel!
    @IBOutlet weak var muscles: UILabel!
   @IBAction func addWorkout(_ sender: Any) {
    let alert = UIAlertController(title: "Which Workout?", message: "Choose a workout to add this exercise!", preferredStyle: .actionSheet)
    let work1 = UIAlertAction(title: "Notes 1", style: .default, handler: { action in self.performSegue(withIdentifier: "note1", sender: self)})
    alert.addAction(work1)
    let work2 = UIAlertAction(title: "Notes 2", style: .default, handler: { action in self.performSegue(withIdentifier: "note2", sender: self)})
    alert.addAction(work2)
    let work3 = UIAlertAction(title: "Notes 3", style: .default, handler: { action in self.performSegue(withIdentifier: "note3", sender: self)})
    alert.addAction(work3)
        let Canaction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(Canaction)
        self.present(alert, animated: true, completion: nil)
    }
    // Declaration to change heading to specific exercise
    @IBOutlet weak var Exercises: UINavigationItem!
    var heading = ""
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
    exerciseImage.alpha = 0
    
    // Index connections along the passing of data from view controllers
    Imp.text = why[myIndex]
    No1.text = step1[myIndex]
    No2.text = step2[myIndex]
    No3.text = step3[myIndex]
    muscles.text = muscleUsed[myIndex]
    exerciseImage.image = UIImage(named: exercises[myIndex] + ".jpg")
    
    // Title of view controller equals exercise selection
    Exercises.title = heading
}
    // Do additional tasks associated with presenting the view
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
       
        UIView.animate(withDuration: 0.5, animations: {
            self.exerciseImage.alpha = 1 })
    }
}
