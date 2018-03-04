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
import FirebaseDatabase
import KeychainSwift

class SignUpViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet var ExperienceTextField: UITextField!
    
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!

    var data = ["I know nothing 🤷‍♂️", "I know something 👀", "I know everything 💪"]
    var picker = UIPickerView()

    //Link text fields to this code
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var EmailAddressTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    let Keychain = DataService().Keychain
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        FirstNameTextField.delegate = self
        LastNameTextField.delegate = self
        EmailAddressTextField.delegate = self
        PasswordTextField.delegate = self
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [UIColor(red: 156/255.5, green: 102/255.5, blue: 211/255.5, alpha: 1.0).cgColor, UIColor(red: 249/255.5, green: 122/255.5, blue: 225/255.5, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint (x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint (x: 1.0, y: 0.5)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        
        if Keychain.get("uid") != nil {
            _ = DataService().Keychain
            performSegue(withIdentifier: "SignUpSegue", sender: nil)
        }
    }
    
    func CompleteSignUp(id: String) {
        
        Keychain.set(id, forKey: "uid")
    }
    
    @IBAction func SignUpButton(_ sender: Any) {
        if let email = EmailAddressTextField.text, let password = PasswordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    self.CompleteSignUp(id: user!.uid)
                    self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
                } else {
                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                        if error != nil {
                            print ("Can't sign in user")
                        } else {
                            self.CompleteSignUp(id: user!.uid)
                            self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
                            
                        }
                    }
                }
            }
        }
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
    
    
}
