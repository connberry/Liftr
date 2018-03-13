//
//  PedometerViewController.swift
//  
//
//  Created by Connor Berry on 09/03/2018.
//

import UIKit
import CoreMotion
import Dispatch
import Firebase

class PedometerViewController: UIViewController {
    
    // Declarations of Pedometer
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    private var shouldStartUpdating: Bool = false
    private var startDate: Date? = nil
    var stepNumberVule: Int = 0 // Practice code
    
    // Storyboard connections
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stepsCountLabel: UILabel!
    @IBOutlet weak var activityTypeLabel: UILabel!
   
    // Practice code start
    func getPedValue() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("user").child(userID!).child("daily").observeSingleEvent(of: .value, with: { (snapshot) in
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
        let key = ref.child("user").child(user).child("daily")
        ref.child("user/\(user)/pedometer").setValue(self.stepNumberVule)
        
    }
    //Practice code end
    
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
   
    // Navigation bar gradient image
    let img = UIImage(named: "Navigation.png")
    navigationController?.navigationBar.barTintColor = UIColor(patternImage: img!)
}
    // Do additional tasks associated with presenting the view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let startDate = startDate else { return }
        updateStepsCountLabelUsing(startDate: startDate)
}
    // Go! button tapped
    @objc private func didTapStartButton() {
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
                    self?.stepsCountLabel.text = String(describing: pedometerData.numberOfSteps)
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
                self?.stepsCountLabel.text = pedometerData.numberOfSteps.stringValue
            }
        }
    }
    // NHS button pressed
    @IBAction func WhyImportantPressed(_ sender: Any) { UIApplication.shared.open(URL(string: "https://www.nhs.uk/Livewell/getting-started-guides/Pages/getting-started-walking.aspx")! as URL, options: [:], completionHandler: nil)
}
    
    

}
