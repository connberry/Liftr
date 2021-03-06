//  SignUpViewController.swift
//  Liftr2
//  Created by Connor Berry on 10/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase
import NotificationBannerSwift

class SignUpViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Gym picker view declarations
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1 }
    var data = ["Newbie 🤷‍♂️", "Skilled 👀", "Expert 💪"]
    var picker = UIPickerView()

    // Storyboard connections
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var EmailAddressTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet var ExperienceTextField: UITextField!
    @IBAction func WhatisLiftr(_ sender: Any) {
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    // Storyboard delegates and datasources
    EmailAddressTextField.delegate = self
    PasswordTextField.delegate = self
    FirstNameTextField.delegate = self
    LastNameTextField.delegate = self
    ExperienceTextField.inputView = picker
    picker.delegate = self
    picker.dataSource = self
    // Start of hide keyboard
    self.FirstNameTextField.delegate = self
}
    // Gym picker view selection
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int { return 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return data.count }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) { ExperienceTextField.text = data[row] }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return data[row] }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    // Once signed in user goes straight to Profile
    if Auth.auth().currentUser != nil {
    self.performSegue(withIdentifier: "SignUpSegue", sender: self) }
}
    // Create user and import to Firebase
    @IBAction func SignUpButton(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        Auth.auth().createUser(withEmail: EmailAddressTextField.text!, password: PasswordTextField.text!, completion: { (user: User?, error: Error?) in
            if error != nil {
                let banner = NotificationBanner(title: "Success, Welcome to Liftr 🏃‍♀️", style: .success)
                banner.show()
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
    let newUserRef = usersReference.child(uid!).child("user details")
            newUserRef.setValue(["email": self.EmailAddressTextField.text!, "first name": self.FirstNameTextField.text!, "last name": self.LastNameTextField.text!, "experience": self.ExperienceTextField.text!])
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
    // Lastname validation - text needs to be evident
    if ExperienceTextField.text == "" {
    let alertController = UIAlertController(title: "Oh dear...", message: "Enter your experience... 🤦‍♂️", preferredStyle: .alert)
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
    displayAlert(messageToDisplay: "We all know thats not a real email 📩")
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
    
    // Email validation - email correct function
    func displayAlert(messageToDisplay: String) {
    let alertController = UIAlertController(title: "Oh dear...", message: messageToDisplay, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
    
    // Will print and show email validation alert
    print("Ok button tapped"); }
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion:nil) }
}
