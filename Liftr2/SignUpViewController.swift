//
//  SignUpViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 10/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet var ExperienceTextField: UITextField!
    
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    
    var data = ["Beginner", "Sort of Know What I'm Doing", "Expert"]
    var picker = UIPickerView()

    //Link text fields to this code
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var EmailAddressTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
    picker.delegate = self
    picker.dataSource = self
        ExperienceTextField.inputView = picker
        
    //Start of hide keyboard
    self.FirstNameTextField.delegate = self
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ExperienceTextField.text = data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        FirstNameTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func CancelButtonTapped(_ sender: Any) {
        print("Cancel Button Tapped")
    
    //Return to Sign In page
    self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SignUpButtonTapped(_ sender: Any) {
        print("Sign Up Button Tapped")
    }
    
}
