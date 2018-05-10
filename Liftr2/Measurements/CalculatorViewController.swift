//
//  CalculatorViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 04/05/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit
import Firebase
import NotificationBannerSwift

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    
    var ref: DatabaseReference?
     var animationHasBeenShown = false

    @IBOutlet weak var value1: UITextField!
    @IBOutlet weak var value2: UITextField!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var value11: UITextField!
    @IBOutlet weak var value22: UITextField!
    @IBOutlet weak var total1: UILabel!
    @IBOutlet weak var value111: UITextField!
    @IBOutlet weak var value222: UITextField!
    @IBOutlet weak var total2: UILabel!
    
    @IBOutlet weak var bmi: UIView!
    @IBOutlet weak var bodyfat: UIView!
    @IBOutlet weak var kcal: UIView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //BMI
    @IBAction func calc(_ sender: Any) {
        //Height / (Weight x Weight) = BMI
        if self.value1.text! != "" && self.value2.text! != "" {
            let textfieldInt = Float(value1.text!)
            let textfield2Int = Float(value2.text!)
            let square = textfield2Int!*textfield2Int!
            var bmi:Float = textfieldInt!/square * 10000
            let formatter = NumberFormatter()
            //Set the min and max number of digits to your liking, make them equal if you want an exact number of digits
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 2
            formatter.string(from: NSNumber(value: bmi))
            self.total.text = formatter.string(from: NSNumber(value: bmi))! + " BMI"
            let banner = StatusBarNotificationBanner(title: "Calculation Done! Submit to save. ✅", style: .warning)
            banner.show(queuePosition: .front)
        }
    }
        @IBAction func submit(_ sender: Any) {
            let dict = (["bmi": self.total.text!, "date": self.getDate()])
        ref?.child("user").child(Auth.auth().currentUser!.uid).child("measurements").child("calculations").child("bmi").child("\(getDate())").setValue(dict)
            total.text = ""
            let banner = NotificationBanner(title: "Success, BMI has been saved today ⚖️", style: .success)
            banner.show(queuePosition: .front)
        }
    //BMI
    
    //BODYFAT%
    @IBAction func calc1(_ sender: Any) {
        //(1.20 x BMI) + (0.23 x Age) - 5.4 = Body Fat Percentage
        if self.value11.text! != "" && self.value22.text! != "" {
            let textfieldInt = Float(value11.text!)
            let textfield2Int = Float(value22.text!)
            var bmi:Float = (1.2 * textfieldInt!) + (0.23 * textfield2Int!) - 5.4
            let formatter = NumberFormatter()
            //Set the min and max number of digits to your liking, make them equal if you want an exact number of digits
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 2
            formatter.string(from: NSNumber(value: bmi))
            self.total1.text = formatter.string(from: NSNumber(value: bmi))! + "%"
            let banner = StatusBarNotificationBanner(title: "Calculation Done! Submit to save. ✅", style: .warning)
            banner.show(queuePosition: .front)
        }
    }
    @IBAction func submit1(_ sender: Any) {
        let dict = (["bodyfat %": self.total1.text!, "date": self.getDate()])
        ref?.child("user").child(Auth.auth().currentUser!.uid).child("measurements").child("calculations").child("bodyfat %").child("\(getDate())").setValue(dict)
        total.text = ""
        let banner = NotificationBanner(title: "Success, Body Fat Percentage has been saved today ⚖️", style: .success)
        banner.show(queuePosition: .front)
    }
    //BODYFAT%
    
    //STEPSvsCALORIES
    @IBAction func calc2(_ sender: Any) {
        //(1.20 x BMI) + (0.23 x Age) - 5.4 = Body Fat Percentage
        if self.value111.text! != "" && self.value222.text! != "" {
            let textfieldInt = Float(value111.text!)
            let textfield2Int = Float(value222.text!)
            var bmi:Float = (((textfieldInt! * 2.204623) * 0.5) / 1500) * textfield2Int!
            let formatter = NumberFormatter()
            //Set the min and max number of digits to your liking, make them equal if you want an exact number of digits
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            formatter.string(from: NSNumber(value: bmi))
            self.total2.text = formatter.string(from: NSNumber(value: bmi))! + " kcal"
            let banner = StatusBarNotificationBanner(title: "Calculation Done! Submit to save. ✅", style: .warning)
            banner.show(queuePosition: .front)
        }
    }
    @IBAction func submit2(_ sender: Any) {
        let dict = (["kcal": self.total2.text!, "date": self.getDate()])
        ref?.child("user").child(Auth.auth().currentUser!.uid).child("measurements").child("calculations").child("kcal").child("\(getDate())").setValue(dict)
        total.text = ""
        let banner = NotificationBanner(title: "Success, Step Calories Burnt has been saved today ⚖️", style: .success)
        banner.show(queuePosition: .front)
    }
    //STEPSvsCALORIES
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
            bmi.center.x -= view.bounds.width
            bodyfat.center.x -= view.bounds.width
            kcal.center.x -= view.bounds.width
        
        // Database Reference
        ref = Database.database().reference()
        
        bmi.layer.borderColor = UIColor.lightGray.cgColor
        bmi.layer.borderWidth = 0.3
        bodyfat.layer.borderColor = UIColor.lightGray.cgColor
        bodyfat.layer.borderWidth = 0.3
        kcal.layer.borderColor = UIColor.lightGray.cgColor
        kcal.layer.borderWidth = 0.3

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        value2.becomeFirstResponder()
        // Animate view in
        if !animationHasBeenShown {
            UIView.animate(withDuration: 0.7, delay: 0.0, options: [.curveEaseOut], animations: {
                self.bmi.center.x += self.view.bounds.width
            }, completion: nil)
            UIView.animate(withDuration: 0.7, delay: 0.0, options: [.curveEaseOut], animations: {
                self.bodyfat.center.x += self.view.bounds.width
            }, completion: nil)
            UIView.animate(withDuration: 0.7, delay: 0.0, options: [.curveEaseOut], animations: {
                self.kcal.center.x += self.view.bounds.width
            }, completion: nil)
            animationHasBeenShown = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        // hours + min:  -\(calendar.component(.hour, from: date))-\(calendar.component(.minute, from: date))
        return "\(calendar.component(.year, from: date))-\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))"
    }

}
