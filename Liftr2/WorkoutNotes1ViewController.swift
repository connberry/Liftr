//
//  Workout1ViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 08/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit
import Firebase

class WorkoutNotes1ViewController: UIViewController {
    
    
    var addExer = [AddExer]()
    @IBOutlet weak var tableView: UITableView!

    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DatabaseService.shared.addExRef.observe(DataEventType.value, with:  { (snapshot) in
            print(snapshot)
            
            guard let addExerSnapshot = ExerSnapshot(with: snapshot) else { return }
            self.addExer = addExerSnapshot.addExer
            self.tableView.reloadData()
            
        })
        
    }
    @IBAction func AddExerciseTapped(_ sender: Any) {
    
    let alert = UIAlertController(title: "Enter an exercise to your list 💪", message: "Check out the exercises tab for ideas!", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Exercise Name, Sets X Reps (10X3) "
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addExer = UIAlertAction(title: "Add", style: .default) { _ in guard let text = alert.textFields?.first?.text else {return}
            print(text)
        
            
            let dateString = String(describing: Date())
            let parameters = ["workName": "Workout 1", "message": text, "date": dateString]
            
            DatabaseService.shared.addExRef.childByAutoId().setValue(parameters)
        
        
        }
        alert.addAction(cancel)
        alert.addAction(addExer)
        present(alert, animated: true, completion: nil)
    
    }
}

extension WorkoutNotes1ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addExer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = addExer[indexPath.row].message
        cell.detailTextLabel?.text = addExer[indexPath.row].workName
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
