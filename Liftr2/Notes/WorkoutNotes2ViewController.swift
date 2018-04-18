//  WorkoutNotes2ViewController.swift
//  Liftr2
//  Created by Connor Berry on 10/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase
import NotificationBannerSwift

class WorkoutNotes2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // Declarations of Database and Added Exercise
    var addExer:[String] = []
    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    var keyArray: [String] = []
    
    //timer
    var timer = Timer()
    var time: Int = 0
    let watch = Stopwatch()
    
    // Storyboard connections
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exerView: UITextField!
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var stop: UILabel!
    
    @IBAction func reset(_ sender: Any) {
        let banner = StatusBarNotificationBanner(title: "Reset \(navigationItem.title!) Workout! ⏰", style: .danger)
        banner.show(queuePosition: .front)
        timer.invalidate()
        time = 0
        stop.text = ("0:00:00")
    }
    
    @IBAction func go(_ sender: Any) {
        let banner = StatusBarNotificationBanner(title: "Started \(navigationItem.title!) Workout! ⏰", style: .success)
        banner.show(queuePosition: .front)
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseInOut], animations: {
            self.timerView.frame.origin.y = self.view.bounds.width - 350
            
        }, completion: nil )
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateLabel(timer:)), userInfo: nil, repeats: true)
        watch.start()
    }
    
    @objc func updateLabel (timer: Timer)
    {
        if watch.isRunning
        {
            let hours = Int(watch.elapsedTime) / 3600
            let minutes = Int(watch.elapsedTime) / 60
            let seconds = Int(watch.elapsedTime) % 60
            stop.text = String(format: "%02d:%02d:%d", hours, minutes, seconds)
        }
        else{
            timer.invalidate()
        }
    }
    
    
    @IBAction func completeWorkout(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 2").child("completed workouts").childByAutoId().setValue("\(getDate())")
        
        timer.invalidate()
        time = 0
        stop.text = ("0:00:00")
        
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseInOut], animations: {
            self.timerView.center.y -= self.view.bounds.height - 100
        }, completion: nil )
        
        let alertController = UIAlertController(title: "Great Workout!", message: "Good going! Your data has been saved. Check it out along with your previous workouts. 💪", preferredStyle: .actionSheet)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        let work1 = UIAlertAction(title: "Completed \(navigationItem.title!) Workouts", style: .default, handler: { action in self.performSegue(withIdentifier: "comp2", sender: self)})
        alertController.addAction(work1)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        // hours + min:  -\(calendar.component(.hour, from: date))-\(calendar.component(.minute, from: date))
        return "\(calendar.component(.year, from: date))-\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))"
        
    }
    @IBAction func inputButton(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
    // Current user insert of exercise
    if exerView.text != "" {
            ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 2").childByAutoId().setValue(exerView.text)
            exerView.text = ""
        let banner = NotificationBanner(title: "Success, Exercise has been saved 🏃‍♀️", style: .success)
        banner.show(queuePosition: .front)
        }
    else
    // Alert if nothing is entered
    if exerView.text == "" {
        let banner = NotificationBanner(title: "You've Entered Nothing 😳", style: .danger)
        banner.show(queuePosition: .front)
        }
}
    // Table returns number of exercises
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addExer.count
    }
    // Cell textLabel equals exercise entered
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = addExer[indexPath.row]
        return cell
    }
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser?.uid != nil {
            Database.database().reference().child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes names").observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dict["notes 2"] as? String
                    
                }
            })
        }
        
        exerView.layer.cornerRadius = 20.0
        exerView.frame.origin.y -= view.bounds.width
        timerView.layer.cornerRadius = 20.0
        timerView.frame.origin.y -= view.bounds.width
        
    tableView.allowsMultipleSelectionDuringEditing = true
        
    // Start of hide keyboard
    self.exerView.delegate = self
     
    // Database Reference
    ref = Database.database().reference()
    
     // Adds notes child
    handle = ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 2").observe(.childAdded, with: { (snapshot) in
        if let item = snapshot.value as? String
            {
                self.addExer.append(item)
                self.tableView.reloadData()
            }
        })
        
}
    // Allows editing of cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
}
    // Delete cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if editingStyle == .delete {
        GetAllKeys()
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when, execute: {
        self.ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 2").child(self.keyArray[indexPath.row]).removeValue()
            let banner = NotificationBanner(title: "Exercise deleted! 🗑", style: .danger)
            banner.show(queuePosition: .front)
        self.addExer.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.keyArray = []
            })
        }
        
}
    // Retrieves all keys from Firebase
    func GetAllKeys() {
        ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 2").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.keyArray.append(key)
            }
        })
}
    // End of hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //Presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        exerView.resignFirstResponder()
        return true
}
    // Adds checkmark functionality
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            let banner = StatusBarNotificationBanner(title: "Exercise Incomplete! 😔", style: .danger)
            banner.haptic = .none
            banner.show(queuePosition: .front)
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark }
        let banner = StatusBarNotificationBanner(title: "Exercise Complete! 🙌", style: .success)
        banner.show(queuePosition: .front)
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseInOut], animations: {
            self.exerView.frame.origin.y = self.view.bounds.width - 290
        }, completion: nil )}
    
}
