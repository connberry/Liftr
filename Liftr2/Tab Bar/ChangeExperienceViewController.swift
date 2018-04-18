//
//  ChangeExperienceViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 17/04/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit
import Firebase
import NotificationBannerSwift

class ChangeExperienceViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    // Gym picker view declarations
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 }
    var data = ["Newbie 🤷‍♂️", "Skilled 👀", "Expert 💪"]
    var picker = UIPickerView()
    
    // Gym picker view selection
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int { return 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return data.count }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) { ExperienceTextField.text = data[row] }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return data[row] }
    

        @IBOutlet var ExperienceTextField: UITextField!
        @IBOutlet weak var Close: UIButton!
        @IBOutlet weak var Conf: UIButton!
        
        @IBAction func closePop(_ sender: Any) {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            self.view.removeFromSuperview()
        }
    @IBAction func Conf(_ sender: Any) {
    var ref: DatabaseReference!
    ref = Database.database().reference()
ref.child("user").child(Auth.auth().currentUser!.uid).child("experience").setValue(self.ExperienceTextField.text)
        // Lastname validation - text needs to be evident
        if ExperienceTextField.text == "" {
            let banner = NotificationBanner(title: "You failed to enter your experience! 😔", subtitle: "Go back and fix it!", style: .danger)
            banner.show(queuePosition: .front)
        } else {
            let banner = NotificationBanner(title: "Success, Your experience has been saved! 🙌", style: .success)
            banner.show(queuePosition: .front)
        }
    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
             Close.layer.cornerRadius = 25.0
             Conf.layer.cornerRadius = 25.0
             ExperienceTextField.layer.cornerRadius = 30.0
            
            self.ExperienceTextField.delegate = self
            ExperienceTextField.inputView = picker
            picker.delegate = self
            picker.dataSource = self
            
            
            self.view.backgroundColor = UIColor.white
            
        }
    // End of hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
