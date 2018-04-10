//  BicepViewController.swift
//  Liftr2
//  Created by Connor Berry on 10/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase

class BicepViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // Declarations of Database and Added Exercise
    var addMes:[String] = []
    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    var keyArray: [String] = []
    
    @IBOutlet weak var bicep: UIBarButtonItem!
    
    // Storyboard connections
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mesView: UITextField!
    @IBAction func inputButton(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        // Current user insert of exercise
        if mesView.text != "" {
            ref?.child("user").child(Auth.auth().currentUser!.uid).child("measurements").child("bicep").child("\(getDate())").setValue(mesView.text)
            mesView.text = ""
            let alertController = UIAlertController(title: "Nice One!", message: "Your bicep has been stored. If you want to amend, just enter a new weight and it will be overwritten for today. 💪", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else
            // Alert if nothing is entered
            if mesView.text == "" {
                let alertController = UIAlertController(title: "Oh dear...", message: "You can't submit nothing😳", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
        }
    }
    // Table returns number of exercises
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addMes.count
    }
    // Cell textLabel equals exercise entered
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.textLabel?.text = addMes[indexPath.row]
        cell.detailTextLabel?.text = getDate()
        return cell
    }
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Adds target to add measurement type
        mesView.delegate = self
        mesView.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        // Start of hide keyboard
        self.mesView.delegate = self
        
        // Database Reference
        ref = Database.database().reference()
        
        // Adds notes child
        handle = ref?.child("user").child(Auth.auth().currentUser!.uid).child("measurements").child("bicep").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? String
            {
                self.addMes.append(item)
                self.tableView.reloadData()
            }
        })
        
    }
    // Adds measurement
    @objc func textFieldDidChange(textfield: UITextField) {
        
        var text = mesView.text?.replacingOccurrences(of: "cm", with: "")
        text = text! + "cm"
        mesView.text = text
        
        print("Text changed")
    }
    // Allows editing of cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // Delete cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if editingStyle == .delete {
            GetAllKeys()
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when, execute: {
                self.ref?.child("user").child(Auth.auth().currentUser!.uid).child("measurements").child("bicep").child(self.keyArray[indexPath.row]).removeValue()
                
                self.addMes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.keyArray = []
            })
        }
        
    }
    // Retrieves all keys from Firebase
    func GetAllKeys() {
        ref?.child("user").child(Auth.auth().currentUser!.uid).child("measurements").child("bicep").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.keyArray.append(key)
            }
        })
    }
    // End of hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //Presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mesView.resignFirstResponder()
        return true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    func getDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        // hours + min:  -\(calendar.component(.hour, from: date))-\(calendar.component(.minute, from: date))
        return "\(calendar.component(.year, from: date))-\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))"
    }
    // How button pressed
    @IBAction func How(_ sender: Any) { UIApplication.shared.open(URL(string: "https://www.wikihow.com/Measure-Biceps")! as URL, options: [:], completionHandler: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
