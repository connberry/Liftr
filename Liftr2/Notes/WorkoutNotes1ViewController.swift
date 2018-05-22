//  Workout1ViewController.swift
//  Liftr2
//  Created by Connor Berry on 07/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase
import NotificationBannerSwift

class WorkoutNotes1ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var add: UIButton!
    @IBAction func name1(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        if exerTextField1?.text != "" {
        let alertController = UIAlertController(title: "Add Exercise", message: "Add a custom exercise to your workout! 💪", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Add", style: .default, handler: { action in
            self.exerView.text = self.exerTextField1?.text
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addTextField { (textField) -> Void in
            self.exerTextField1 = textField
            self.exerTextField1?.placeholder = "Add Exercise"
        }
        alertController.addAction(ok)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // Declarations of Database and Added Exercise
    var exerTextField1: UITextField?
    var addExer = [Exercises]()
    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    var keyArray: [String] = []
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 }
    var data = ["Ab Roller",
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
    var picker = UIPickerView()
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int { return 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return data.count }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) { exerView.text = data[row] }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return data[row] }
    //timer
    var timer = Timer()
    var time: Int = 0
    let watch = Stopwatch()
    
    // Storyboard connections
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exerView: UITextField!
    @IBOutlet weak var repView: UITextField!
    @IBOutlet weak var setView: UITextField!
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var stop: UILabel!
    
    @IBAction func reset(_ sender: Any) {
        timerView.backgroundColor = UIColor(red:0.88, green:0.32, blue:0.29, alpha:1.0)
        let banner = NotificationBanner(title: "Reset \(navigationItem.title!) Workout! ⏰", style: .danger)
        banner.show(bannerPosition: .bottom)
        timer.invalidate()
        time = 0
        stop.text = ("00:00:0")
    }
    @IBAction func go(_ sender: Any) {
       
        timerView.backgroundColor = UIColor(red:0.28, green:0.79, blue:0.48, alpha:1.0)
        let banner = NotificationBanner(title: "Started \(navigationItem.title!) Workout! ⏰", style: .success)
        banner.show(bannerPosition: .bottom)
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseInOut], animations: {
            self.timerView.frame.origin.y = self.view.bounds.width - 365
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
        let dict = (["workout": self.navigationItem.title!, "date": self.getDate()])
        ref.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("completed workouts").childByAutoId().setValue(dict)
        
        timer.invalidate()
        time = 0
        stop.text = ("00:00:0")
       
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseInOut], animations: {
            self.timerView.center.y -= self.view.bounds.height - 100
             }, completion: nil )
        
        let alertController = UIAlertController(title: "Great Workout!", message: "Good going! Your data has been saved. Check it out along with your previous workouts. 💪", preferredStyle: .actionSheet)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        let work1 = UIAlertAction(title: "Completed \(navigationItem.title!) and Other Workouts", style: .default, handler: { action in self.performSegue(withIdentifier: "comp1", sender: self)})
        alertController.addAction(work1)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func inputButton(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
     
    // Current user insert of exercise
    if exerView.text != "" {
        let dict = (["exercises": self.exerView.text!, "reps": self.repView.text!, "sets": self.setView.text!])
        ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 1").childByAutoId().setValue(dict)
            exerView.text = ""
        let banner = NotificationBanner(title: "Success, Exercise has been saved 🏃‍♀️", subtitle: "Tap to dismiss me!", style: .success)
        banner.show(bannerPosition: .bottom)
}
    else
    // Alert if nothing is entered
    if exerView.text == "" {
        let banner = NotificationBanner(title: "You've Entered Nothing 😳", subtitle: "Tap to dismiss me!", style: .danger)
        banner.show(bannerPosition: .bottom)
        }
    }
    // Table returns number of exercises
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addExer.count
    }
    // Cell textLabel equals exercise entered
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCustomTableViewCell
        let test = addExer[indexPath.row]
        cell.exercise?.text = test.exercises
        cell.reps?.text = test.reps
        cell.sets?.text = test.sets
        
        return cell
    }

    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerView.inputView = picker
        picker.delegate = self
        picker.dataSource = self
        
        
        if Auth.auth().currentUser?.uid != nil {
            Database.database().reference().child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes names").observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dict["notes 1"] as? String
                    
                }
            })
        }
        
        repView.layer.cornerRadius = 20.0
        setView.layer.cornerRadius = 20.0
        exerView.layer.cornerRadius = 20.0
        exerView.frame.origin.y -= view.bounds.width
        setView.frame.origin.y -= view.bounds.width
        repView.frame.origin.y -= view.bounds.width
        timerView.layer.cornerRadius = 20.0
        timerView.frame.origin.y -= view.bounds.width
        
    tableView.allowsMultipleSelectionDuringEditing = true
        
    // Start of hide keyboard
    self.exerView.delegate = self
    
    // Database Reference
    ref = Database.database().reference()
     
    // Adds notes child
    handle = ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 1").observe(.childAdded, with: { (snapshot) in
        let results = snapshot.value as? [String : AnyObject]
        let exercises = results?["exercises"]
        let reps = results?["reps"]
        let sets = results?["sets"]
        let data = Exercises(exercises: exercises as! String?, reps: reps as! String?, sets: sets as! String?)
        self.addExer.append(data)
        self.tableView.reloadData()
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
            let banner = NotificationBanner(title: "Exercise deleted! 🗑", style: .danger)
            banner.show(queuePosition: .front)
            self.ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 1").child(self.keyArray[indexPath.row]).removeValue()

        self.addExer.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.keyArray = []
            })
        }
        
}
    // Retrieves all keys from Firebase
    func GetAllKeys() {
        ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 1").observeSingleEvent(of: .value, with: { (snapshot) in
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
    
    func getDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        // hours + min:  -\(calendar.component(.hour, from: date))-\(calendar.component(.minute, from: date))
        return "\(calendar.component(.year, from: date))-\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))"
        
    }
    // Adds checkmark functionality
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        } else {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            let banner = StatusBarNotificationBanner(title: "Exercise Complete! 🙌", style: .success)
            banner.show(queuePosition: .front)
        }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseInOut], animations: {
            self.exerView.frame.origin.y = self.view.bounds.width - 315
        }, completion: nil )
        
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseInOut], animations: {
            self.setView.frame.origin.y = self.view.bounds.width - 260
        }, completion: nil )
        
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseInOut], animations: {
            self.repView.frame.origin.y = self.view.bounds.width - 260
        }, completion: nil )}
    
    @IBAction func superset(_ sender: UIButton) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
            let banner = StatusBarNotificationBanner(title: "Supersetting Exercise!🔝", style: .success)
            banner.show(queuePosition: .front)
        
        if sender.currentImage == #imageLiteral(resourceName: "Superset Off") {
        toggle(button: sender, onImage: #imageLiteral(resourceName: "Superset On"), offImage: #imageLiteral(resourceName: "Superset Off"))
    }
}
    func toggle (button: UIButton, onImage: UIImage, offImage: UIImage) {
        if button.currentImage == offImage {
            button.setImage(onImage, for: .normal)
        } else {
            button.setImage(offImage, for: .normal)
        }
    }
}
