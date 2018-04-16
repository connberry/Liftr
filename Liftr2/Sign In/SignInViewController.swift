//  SignInViewController.swift
//  Liftr2
//  Created by Connor Berry on 07/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import Foundation
import UIKit
import Firebase
import NotificationBannerSwift

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    // Storyboard connections
    @IBOutlet weak var EmailAddressTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Start of hide keyboard and delegates
    self.EmailAddressTextField.delegate = self
    EmailAddressTextField.delegate = self
    PasswordTextField.delegate = self
}
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Log in button function
    @IBAction func LogInButton(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    // Email Address and Password fields must match that of the Firebase database
        if (EmailAddressTextField.text != "" && PasswordTextField.text != ""){
        Auth.auth().signIn(withEmail: EmailAddressTextField.text!, password: PasswordTextField.text!) { user, error in
        if error == nil {
        let banner = NotificationBanner(title: "Success, Welcome back to Liftr 🏃‍♀️", style: .success)
        banner.show()
        self.performSegue(withIdentifier: "LogInSegue", sender: nil) } else {
    // If incorrect show this alert
        let alert = UIAlertController(title: "Oh dear...", message: "You've gone and entered incorrect details, try harder next time! 🤦‍♀️", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil) }
            }
        }
}
    // End of hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //Presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Try to find next responder (textfields)
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
    // Not found, so remove keyboard from view
            textField.resignFirstResponder()
        }
    // Do not add a line break
        return false
    }
}
