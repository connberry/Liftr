//
//  SignInViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 09/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var EmailAddressTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Start of hide keyboard
        self.EmailAddressTextField.delegate = self
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
        EmailAddressTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func SignInButtonTapped(_ sender: Any) {
        print("Sign In Button Tapped")
    }
    
    @IBAction func SignUpButtonTapped(_ sender: Any) {
        print("Register Account Button Tapped")
        
        let SignUpViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        self.present(SignUpViewController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
