//  PedometerViewController.swift
//  Liftr2
//  Created by Connor Berry on 07/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import CoreMotion
import Dispatch
import Firebase
import UserNotifications

class PedometerViewController: UIViewController {
    
    var animationHasBeenShown = false
    @IBOutlet weak var steps: UIView!
    @IBOutlet weak var movement: UIView!
    @IBOutlet weak var ready: UIButton!
    
    // Declarations of Pedometer
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    private var shouldStartUpdating: Bool = false
    private var startDate: Date? = nil
    var stepNumberVule: Int = 0
    
    // Storyboard connections
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stepsCountLabel: UILabel!
    @IBOutlet weak var activityTypeLabel: UILabel!
    
    @IBAction func Info(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Don't kill us!", message: "If you force quit the app you lose your steps so please don't kill us. 🏃‍♀️", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
    }
    
    private func updateStepCounterValue(_ numberOfSteps: NSNumber) {
        stepNumberVule = numberOfSteps.intValue
        stepsCountLabel.text = numberOfSteps.stringValue
    }
   
    func getPedValue() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("user").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
    let value = snapshot.value as? NSDictionary
    let ped:Int = value?["pedometer"] as? Int ?? 0
     self.stepNumberVule = ped
     self.stepsCountLabel.text = ("\(self.stepNumberVule)")
        }) { (error) in
            print(error.localizedDescription)
        }
        }
    
    @IBAction func Save(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let user = Auth.auth().currentUser!.uid
        let date = Date()
        let key = ref.child("user").child(user).child("pedometer").child(getDate()).updateChildValues(["steps": stepNumberVule])

    }
    
    func getDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        // hours + min:  -\(calendar.component(.hour, from: date))-\(calendar.component(.minute, from: date))
        return "\(calendar.component(.year, from: date))-\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))"
        
    }
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        steps.center.y += view.bounds.width
        movement.center.y += view.bounds.width
        ready.center.y += view.bounds.width
        steps.layer.cornerRadius = 30.0
        movement.layer.cornerRadius = 30.0
        ready.layer.cornerRadius = 25.0
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            
        })
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
}
    // Do additional tasks associated with presenting the view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !animationHasBeenShown {
            UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseOut], animations: {
                self.steps.center.y -= self.view.bounds.height - 225
            }, completion: nil)
            UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseOut], animations: {
                self.movement.center.y -= self.view.bounds.height - 225
            }, completion: nil)
            UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseOut], animations: {
                self.ready.center.y -= self.view.bounds.height - 225
            }, completion: nil)
            animationHasBeenShown = true
        }
        
        guard let startDate = startDate else { return }
        updateStepsCountLabelUsing(startDate: startDate)
}
    @IBAction func Ready(_ sender: AnyObject) {
        self.startButton.isHidden = true
        let content = UNMutableNotificationContent()
        content.title = "Don't force quit the app!"
        content.body = "You will lose your daily steps, so never force quit Liftr."
        content.badge = 0
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "stepClose", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    // Ready? button tapped
    @objc private func didTapStartButton() {
        let popOverVC = UIStoryboard(name: "Tab Bar", bundle: nil).instantiateViewController(withIdentifier: "PopUp") as! PopUpViewController
        self.addChildViewController(popOverVC)
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        shouldStartUpdating = !shouldStartUpdating
        shouldStartUpdating ? (onStart()) : (onStop())
    }
}

// Pedometer Extension and its private fuctions (functions are explained explicitly so no need for comments)
extension PedometerViewController {
    private func onStart() {
        startButton.setTitle("Stop", for: .normal)
        startDate = Date()
        checkAuthorizationStatus()
        startUpdating()
}
    
    private func onStop() {
        startButton.setTitle("Start", for: .normal)
        startDate = nil
        stopUpdating()
}
    
    private func startUpdating() {
        if CMMotionActivityManager.isActivityAvailable() {
            startTrackingActivityType()
        } else {
            activityTypeLabel.text = "Not available"
}
        
        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        } else {
            stepsCountLabel.text = "Not available"
        }
}
    
    private func checkAuthorizationStatus() {
        switch CMMotionActivityManager.authorizationStatus() {
        case CMAuthorizationStatus.denied:
            onStop()
            activityTypeLabel.text = "Not available"
            stepsCountLabel.text = "Not available"
        default:break
        }
}
    
    private func stopUpdating() {
        activityManager.stopActivityUpdates()
        pedometer.stopUpdates()
        pedometer.stopEventUpdates()
}
    
    private func on(error: Error) {
        //handle error
}
    
    // Update step count
    private func updateStepsCountLabelUsing(startDate: Date) {
        pedometer.queryPedometerData(from: startDate, to: Date()) {
            [weak self] pedometerData, error in
            if let error = error {
                self?.on(error: error)
            } else if let pedometerData = pedometerData {
                DispatchQueue.main.async {
                    self?.updateStepCounterValue(pedometerData.numberOfSteps)
                }
            }
        }
}
    // Activity type
    private func startTrackingActivityType() {
        activityManager.startActivityUpdates(to: OperationQueue.main) {
            [weak self] (activity: CMMotionActivity?) in
            guard let activity = activity else { return }
            DispatchQueue.main.async {
                if activity.walking {
                    self?.activityTypeLabel.text = "You're walking, go faster! 🚶‍♀️"
                } else if activity.stationary {
                    self?.activityTypeLabel.text = "You're still, stop being lazy 😴"
                } else if activity.running {
                    self?.activityTypeLabel.text = "You're running, nice one! 🏃‍♀️"
                } else if activity.automotive {
                    self?.activityTypeLabel.text = "Driving doesnt count... 🚗"
                }
            }
        }
    }
    // Start counting steps
    private func startCountingSteps() {
        pedometer.startUpdates(from: Date()) {
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return }
            
            DispatchQueue.main.async {
        self?.updateStepCounterValue(pedometerData.numberOfSteps)
            }
        }
    }
    // NHS button pressed
    @IBAction func WhyImportantPressed(_ sender: Any) { UIApplication.shared.open(URL(string: "https://www.nhs.uk/Livewell/getting-started-guides/Pages/getting-started-walking.aspx")! as URL, options: [:], completionHandler: nil)
}


}
