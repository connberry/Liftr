//
//  ForgottenViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 10/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit
import Firebase

class ForgottenViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var EmailAddressTextField: UITextField!
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start of hide keyboard
        self.EmailAddressTextField.delegate = self
        
        // Background gradient colour, direction and frame
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [UIColor(red: 156/255.5, green: 102/255.5, blue: 211/255.5, alpha: 1.0).cgColor, UIColor(red: 249/255.5, green: 122/255.5, blue: 225/255.5, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint (x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint (x: 1.0, y: 0.5)
        self.view.layer.insertSublayer(gradientLayer, at: 0)

    }
    
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        let email = EmailAddressTextField.text
        Auth.auth().sendPasswordReset(withEmail: email!) { (error) in
            if let error = error {
                print(error)
            } else {
                print("Password Reset Sent")
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // End of hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //Presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        EmailAddressTextField.resignFirstResponder()
        return true
}
}
