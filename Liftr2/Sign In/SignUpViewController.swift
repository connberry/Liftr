//  SignUpViewController.swift
//  Liftr2
//  Created by Connor Berry on 10/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var animationHasBeenShown = false
    // Gym picker view declarations
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1 }
    var data = ["I know nothing 🤷‍♂️", "I know something 👀", "I know everything 💪"]
    var picker = UIPickerView()

    // Storyboard connections
    
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var EmailAddressTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet var ExperienceTextField: UITextField!
    @IBAction func WhatisLiftr(_ sender: Any) {
}
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()

    // Storyboard delegates and datasources
    
    EmailAddressTextField.delegate = self
    EmailAddressTextField.tag = 0
    EmailAddressTextField.center.x -= view.bounds.width
    PasswordTextField.delegate = self
    PasswordTextField.tag = 1
    PasswordTextField.center.x -= view.bounds.width
    FirstNameTextField.delegate = self
    FirstNameTextField.tag = 2
    FirstNameTextField.center.x -= view.bounds.width
    LastNameTextField.delegate = self
    LastNameTextField.tag = 3
    LastNameTextField.center.x -= view.bounds.width
    ExperienceTextField.inputView = picker
    ExperienceTextField.tag = 4
    ExperienceTextField.center.x -= view.bounds.width
    picker.delegate = self
    picker.dataSource = self
        
        
    // Background gradient colour, direction and frame
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.view.frame
    gradientLayer.colors = [UIColor(red: 156/255.5, green: 102/255.5, blue: 211/255.5, alpha: 1.0).cgColor, UIColor(red: 249/255.5, green: 122/255.5, blue: 225/255.5, alpha: 1.0).cgColor]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.startPoint = CGPoint (x: 0.5, y: 1.0)
    gradientLayer.endPoint = CGPoint (x: 1.0, y: 0.5)
    self.view.layer.insertSublayer(gradientLayer, at: 0)
    
    // Start of hide keyboard
    self.FirstNameTextField.delegate = self
}
    // Gym picker view selection
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int { return 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return data.count }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) { ExperienceTextField.text = data[row] }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return data[row] }
    
    // Do additional tasks associated with presenting the view
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !animationHasBeenShown {
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseOut], animations: {
            self.EmailAddressTextField.center.x += self.view.bounds.width
            }, completion: nil)
        UIView.animate(withDuration: 0.7, delay: 0.1, options: [.curveEaseOut], animations: {
            self.PasswordTextField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.7, delay: 0.2, options: [.curveEaseOut], animations: {
            self.FirstNameTextField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.7, delay: 0.3, options: [.curveEaseOut], animations: {
            self.LastNameTextField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.7, delay: 0.4, options: [.curveEaseOut], animations: {
            self.ExperienceTextField.center.x += self.view.bounds.width
        }, completion: nil)
            animationHasBeenShown = true
        }

        
    // Once signed in user goes straight to Profile
    if Auth.auth().currentUser != nil {
    self.performSegue(withIdentifier: "SignUpSegue", sender: self) }
}
    // Create user and import to Firebase
    @IBAction func SignUpButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: EmailAddressTextField.text!, password: PasswordTextField.text!, completion: { (user: User?, error: Error?) in
            if error != nil {
                return }
            let email = self.EmailAddressTextField.text
            Auth.auth().currentUser?.sendEmailVerification { error in
            if let error = error { print(error)
            } else {
            print("Email verification sent") }
}
    let ref = Database.database().reference()
    let usersReference = ref.child("user")
    // print(usersReference.description()) : https://iosliftr.firebaseio.com/users
    let uid = user?.uid
    let newUserRef = usersReference.child(uid!)
    newUserRef.setValue(["email": self.EmailAddressTextField.text!, "first name": self.FirstNameTextField.text!, "last name": self.LastNameTextField.text!])
    print("description \(newUserRef.description())")
})
    // Email validation - text needs to be evident
    if EmailAddressTextField.text == "" {
    let alertController = UIAlertController(title: "Oh dear...", message: "Come on! Your email is wrong 🙄", preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(defaultAction)
    present(alertController, animated: true, completion: nil)
}
    // Password validation - text needs to be evident
    if PasswordTextField.text == ""  {
    let alertController = UIAlertController(title: "Oh dear...", message: "You need to add a password 🤐", preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(defaultAction)
    present(alertController, animated: true, completion: nil)
}
    // Password validation - text must be longer than 6 characters
    if PasswordTextField.text!.count < 6 {
    let alertController = UIAlertController(title: "Oh dear...", message: "Your password isn't long enough, make it 6 characters 📏", preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(defaultAction)
    present(alertController, animated: true, completion: nil)
}
    // Firstname validation - text needs to be evident
    if FirstNameTextField.text == "" {
    let alertController = UIAlertController(title: "Oh dear...", message: "You have a name surely? 🧐", preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
    present(alertController, animated: true, completion: nil)
}
        // Lastname validation - text needs to be evident
    if LastNameTextField.text == "" {
    let alertController = UIAlertController(title: "Oh dear...", message: "You have a name surely? 🧐", preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(defaultAction)
    present(alertController, animated: true, completion: nil)
}
    // Email validation - email is correct format e.g. user@email.com
    let providedEmail = EmailAddressTextField.text
    func isValidEmailAddress(emailAddressString: String) -> Bool {
    var returnValue = true
    let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    do { let regex = try NSRegularExpression(pattern: emailRegEx)
    let nsString = emailAddressString as NSString
    let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
    if results.count == 0
    { returnValue = false }
    } catch let error as NSError { print("invalid regex: \(error.localizedDescription)")
    returnValue = false }
    return  returnValue }
    let isEmailAddressValid = isValidEmailAddress(emailAddressString: providedEmail!)
    if isEmailAddressValid { print("Valid") } else { print("not valid")
    displayAlert(messageToDisplay: "We all know thats not a real email 📩") }
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
    
    // Email validation - email correct function
    func displayAlert(messageToDisplay: String) {
    let alertController = UIAlertController(title: "Oh dear...", message: messageToDisplay, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
    
    // Will print and show email validation alert
    print("Ok button tapped"); }
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion:nil) }
}
