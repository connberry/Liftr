//  WorkoutNotes3ViewController.swift
//  Liftr2
//  Created by Connor Berry on 10/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase

class WorkoutNotes3ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // Declarations of Database and Added Exercise
    var addExer:[String] = []
    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    var keyArray: [String] = []
    
    // Storyboard connections
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exerView: UITextField!
    @IBAction func inputButton(_ sender: Any) {
        
    // Current user insert of exercise
    if exerView.text != "" {
        ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 3").childByAutoId().setValue(exerView.text)
            exerView.text = ""
        }
        else
        // Alert if nothing is entered
        if exerView.text == "" {
        let alertController = UIAlertController(title: "Oh dear...", message: "You can't lift nothing 😑", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
        }
}
    // Table returns number of exercises
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addExer.count
    }
    // Cell textLabel equals exercise entered
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = addExer[indexPath.row]
        return cell
    }
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    tableView.allowsMultipleSelectionDuringEditing = true
        
    // Start of hide keyboard
    self.exerView.delegate = self
        
    // Database Reference
    ref = Database.database().reference()
        
    // Adds notes child
    handle = ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 3").observe(.childAdded, with: { (snapshot) in
        if let item = snapshot.value as? String
            {
                self.addExer.append(item)
                self.tableView.reloadData()
            }
        })
        
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
            self.ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 3").child(self.keyArray[indexPath.row]).removeValue()
                
        self.addExer.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.keyArray = []
            })
        }
        
}
    // Retrieves all keys from Firebase
    func GetAllKeys() {
        ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes 3").observeSingleEvent(of: .value, with: { (snapshot) in
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
        exerView.resignFirstResponder()
        return true
}
    // Adds checkmark functionality
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark }
    }
}
