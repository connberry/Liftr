//  ChallengeViewControleer.swift
//  Liftr2
//  Created by Connor Berry on 07/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import MKRingProgressView

class ChallangeViewController: UIViewController {
    
    var situpNumberVule: Int = 0
    var squatNumberVule: Int = 0
    var lungeNumberVule: Int = 0
    
    @IBOutlet var ringProgress: MKRingProgressView!
    @IBOutlet weak var numberProgress: UILabel!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var textView2: UIView!
    
    func setDailyProgressPercentage() -> Double {
        /*
         This is a function which mathematically works out the overall progression from the
         day and puts it into a ring progression which is a visual representation of the progress
         for the day
         */
        var _:Int = 0
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("user").child(userID!).child("challenge").child(getDate()).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let situp:Int = value?["situp"] as? Int ?? 0
            let squat:Int = value?["squat"] as? Int ?? 0
            let lunge:Int = value?["lunge"] as? Int ?? 0
            self.situpNumberVule = situp
            self.squatNumberVule = squat
            self.lungeNumberVule = lunge
        }) { (error) in
            print(error.localizedDescription)
        }
        let mathNumber: Int = ((self.situpNumberVule + self.squatNumberVule + self.lungeNumberVule) / 3)
        
        self.numberProgress.text = ("\(mathNumber)%")
        return Double(mathNumber / 10)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.center.y -= view.bounds.width
        textView2.center.y -= view.bounds.width
        
        textView.layer.cornerRadius = 30.0
        textView2.layer.cornerRadius = 30.0
        // Do any additional setup after loading the view.
    }
    
    
    func drawRingProgress() {
        /*
         This is the function which initialises the
         ring progress to show on the screen
         */
        CATransaction.begin()
        CATransaction.setAnimationDuration(3.5)
        ringProgress.progress = setDailyProgressPercentage()
        CATransaction.commit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        drawRingProgress()

        UIView.animate(withDuration: 0.6, delay: 1, options: [.curveEaseOut], animations: {
            self.textView.frame.origin.y = self.view.bounds.width - 350
        }, completion: { (true) in gone() })
        func gone() {
            UIView.animate(withDuration: 0.6, delay: 2, options: [.curveEaseIn],
                           animations: {
                            self.textView.center.y -= self.view.bounds.height - 100
            }, completion:  { (true) in txt2() })
            func txt2() {
                UIView.animate(withDuration: 0.6, delay: 1, options: [.curveEaseOut], animations: {
                    self.textView2.frame.origin.y = self.view.bounds.width - 350
                }, completion: { (true) in txt22() })
                
                func txt22() {
                    UIView.animate(withDuration: 0.6, delay: 2, options: [.curveEaseIn],
                                   animations: {
                                    self.textView2.center.y -= self.view.bounds.height - 100
                    }, completion: nil)
                }
            }
        }
    }
    func getDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        // hours + min:  -\(calendar.component(.hour, from: date))-\(calendar.component(.minute, from: date))
        return "\(calendar.component(.year, from: date))-\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))"
    }
    
    
    
    
}
