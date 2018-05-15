//  Exercises2ViewController.swift
//  Liftr2
//  Created by Connor Berry on 18/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase
import NotificationBannerSwift

class Exercises2ViewController: UIViewController {
    
    var ref: DatabaseReference!
    // Storyboard connections
    @IBOutlet weak var Imp: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var No1: UILabel!
    @IBOutlet weak var No2: UILabel!
    @IBOutlet weak var No3: UILabel!
    @IBOutlet weak var muscles: UILabel!
   @IBAction func addWorkout(_ sender: Any) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
    let alert = UIAlertController(title: "Which Workout?", message: "Choose a workout to add this exercise!", preferredStyle: .actionSheet)
    
    let userID = Auth.auth().currentUser?.uid
    ref.child("user").child(userID!).child("workout notes").child("notes names").observeSingleEvent(of: .value, with: { (snapshot) in
        let value = snapshot.value as? NSDictionary
        let note1 = value?["notes 1"] as? String ?? ""
    let work1 = UIAlertAction(title: "\(note1)", style: .default, handler: { action in self.performSegue(withIdentifier: "note1", sender: self)
        let banner = StatusBarNotificationBanner(title: "Exercise copied, just paste and go! 🏋️‍♀️ ", style: .success)
        banner.show(queuePosition: .front)
        })
        alert.addAction(work1)
    })
    
    ref.child("user").child(userID!).child("workout notes").child("notes names").observeSingleEvent(of: .value, with: { (snapshot) in
        let value = snapshot.value as? NSDictionary
        let note2 = value?["notes 2"] as? String ?? ""
    let work2 = UIAlertAction(title: "\(note2)", style: .default, handler: { action in self.performSegue(withIdentifier: "note2", sender: self)
        let banner = StatusBarNotificationBanner(title: "Exercise copied, just paste and go! 🏋️‍♀️ ", style: .success)
        banner.show(queuePosition: .front)
    })
    alert.addAction(work2)
    })
    
    ref.child("user").child(userID!).child("workout notes").child("notes names").observeSingleEvent(of: .value, with: { (snapshot) in
        let value = snapshot.value as? NSDictionary
        let note3 = value?["notes 3"] as? String ?? ""
    let work3 = UIAlertAction(title: "\(note3)", style: .default, handler: { action in self.performSegue(withIdentifier: "note3", sender: self)
        let banner = StatusBarNotificationBanner(title: "Exercise copied, just paste and go! 🏋️‍♀️ ", style: .success)
        banner.show(queuePosition: .front)
    })
    alert.addAction(work3)
    })
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
        
        ref = Database.database().reference()
        
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
