//  ForgottenViewController.swift
//  Liftr2
//  Created by Connor Berry on 07/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase

class ForgottenViewController: UIViewController, UITextFieldDelegate {
    
    // Storyboard connections and variables
    var animationHasBeenShown = false
    @IBOutlet weak var EmailAddressTextField: UITextField!
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    EmailAddressTextField.center.x -= view.bounds.width
    
    // Start of hide keyboard
    self.EmailAddressTextField.delegate = self
}
    // When button is pressed a reset email is sent to user email
    @IBAction func resetButtonPressed(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
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
    // Animate email address in
        if !animationHasBeenShown {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [.curveEaseOut], animations: {
            self.EmailAddressTextField.center.x += self.view.bounds.width
        }, completion: nil)
        animationHasBeenShown = true
        }
}
    // End of hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //Presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        EmailAddressTextField.resignFirstResponder()
        return true }
}
