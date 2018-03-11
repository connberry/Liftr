//
//  WorkoutNotes3ViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 10/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit
import Firebase

class WorkoutNotes3ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var addExer:[String] = []
    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    var keyArray: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exerView: UITextField!
    @IBAction func inputButton(_ sender: Any) {
        
        if exerView.text != ""
        {
            ref?.child("users").child(Auth.auth().currentUser!.uid).child("notes3").childByAutoId().setValue(exerView.text)
            exerView.text = ""
        }
        else
            if exerView.text == "" {
                let alertController = UIAlertController(title: "Oh dear...", message: "You can't lift nothing 😑", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addExer.count
    }
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
        
        ref = Database.database().reference()
        
        handle = ref?.child("users").child(Auth.auth().currentUser!.uid).child("notes3").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? String
            {
                self.addExer.append(item)
                self.tableView.reloadData()
            }
        })
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if editingStyle == .delete {
            GetAllKeys()
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when, execute: {
                self.ref?.child("users").child(Auth.auth().currentUser!.uid).child("notes3").child(self.keyArray[indexPath.row]).removeValue()
                
                self.addExer.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.keyArray = []
            })
        }
        
    }
    
    func GetAllKeys() {
        ref?.child("users").child(Auth.auth().currentUser!.uid).child("notes3").observeSingleEvent(of: .value, with: { (snapshot) in
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
    }
}
