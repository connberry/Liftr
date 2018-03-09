////
////  Workout1ViewController.swift
////  Liftr2
////
////  Created by Connor Berry on 08/03/2018.
////  Copyright © 2018 Connor Berry. All rights reserved.
////
//
import UIKit
import Firebase

class WorkoutNotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var addExer:[String] = []
    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exerView: UITextField!
    @IBAction func inputButton(_ sender: Any) {
        
    if exerView.text != ""
    {
        ref?.child("users").child(Auth.auth().currentUser!.uid).child("notes").childByAutoId().setValue(exerView.text)
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
        
        // Start of hide keyboard
        self.exerView.delegate = self
        
        ref = Database.database().reference()
        
    handle = ref?.child("users").child(Auth.auth().currentUser!.uid).child("notes").observe(.childAdded, with: { (snapshot) in
        if let item = snapshot.value as? String
        {
            self.addExer.append(item)
            self.tableView.reloadData()
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
}
