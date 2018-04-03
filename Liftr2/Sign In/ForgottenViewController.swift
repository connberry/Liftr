//  ForgottenViewController.swift
//  Liftr2
//  Created by Connor Berry on 07/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase

class ForgottenViewController: UIViewController, UITextFieldDelegate {
    
    var animationHasBeenShown = false
    // Storyboard connections
    @IBOutlet weak var EmailAddressTextField: UITextField!
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    EmailAddressTextField.center.x -= view.bounds.width
    
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
    // When button is pressed a reset email is sent to user email
    @IBAction func resetButtonPressed(_ sender: Any) {
        let email = EmailAddressTextField.text
        Auth.auth().sendPasswordReset(withEmail: email!) { (error) in
        if let error = error {
        print(error) } else {
        print("Password Reset Sent") }
        }
        if EmailAddressTextField.text == "" {
            let alertController = UIAlertController(title: "Oh dear...", message: "Come on! Enter your email! 🙄", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !animationHasBeenShown {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [.curveEaseOut], animations: {
            self.EmailAddressTextField.center.x += self.view.bounds.width
        }, completion: nil)
        animationHasBeenShown = true
        }
}
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

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