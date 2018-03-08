//
//  WeightViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 07/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit
import CoreData

class WeightViewController: UIViewController {

   
    @IBOutlet var WeightTextField: UITextField!
    @IBOutlet var Units: UISwitch!
    @IBAction func ButtonSavePressed(_ sender: Any) {
        //Saves Data
        let appDel = UIApplication.shared.delegate as! AppDelegate
    
    }
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()

}
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}


}
