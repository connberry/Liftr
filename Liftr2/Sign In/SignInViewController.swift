//  SignInViewController.swift
//  Liftr2
//  Created by Connor Berry on 07/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import Foundation
import UIKit
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    var animationHasBeenShown = false
    // Storyboard connections
    @IBOutlet weak var EmailAddressTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
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
        
    EmailAddressTextField.delegate = self
    EmailAddressTextField.tag = 0
    EmailAddressTextField.center.x -= view.bounds.width
    PasswordTextField.delegate = self
    PasswordTextField.tag = 1
    PasswordTextField.center.x -= view.bounds.width
}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !animationHasBeenShown {
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseOut], animations: {
            self.EmailAddressTextField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.7, delay: 0.1, options: [.curveEaseOut], animations: {
            self.PasswordTextField.center.x += self.view.bounds.width
        }, completion: nil)
            animationHasBeenShown = true
}
    }
    
    @IBAction func LogInButton(_ sender: Any) {
        if (EmailAddressTextField.text != "" && PasswordTextField.text != ""){
        Auth.auth().signIn(withEmail: EmailAddressTextField.text!, password: PasswordTextField.text!) { user, error in
        if error == nil { 
        self.performSegue(withIdentifier: "LogInSegue", sender: nil) } else {
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
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
}