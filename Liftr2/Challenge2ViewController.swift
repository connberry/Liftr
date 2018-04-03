// Challenge2ViewController.swift
//  Liftr2
//  Created by Connor Berry on 07/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase
import FirebaseDatabase

class Challange2ViewController: UIViewController {
    
    var currentState:Bool = true
    var situpNumberVule: Int = 0 //Number of situps to display on the screen
    var squatNumberVule: Int = 0 //Number of pressups to display on the screen
    var lungeNumberVule: Int = 0 //Number of starjumps to display on the screen
    var lastDate: String! //unused
    var catchGetDateError: Bool = false //catch any errors so that it'll show error
    var rewardInArray: NSArray = [] //Would hold the three medals in an array
    var bruteforceDate: Bool = false //Used to change the date to test
    var bronze: Int = 0 //Used for adding to the bronze total
    var silver: Int = 0 //Used for adding to the silver total
    var gold: Int = 0 //Used for adding to the gold medal total
    var currDate: String = "" //Getting the current date
    var newLastDate: String = "1/1/1970" //Getting the last date that someone used the application
    var currentDate: String = "" //Also getting the current date
    
    //Connect the text labels on the UI to the code, can be called by names.
    @IBOutlet weak var squatValue: UILabel!
    @IBOutlet weak var lungeValue: UILabel!
    
    
    func getCurrentReward() {
        /*
         This function is used to connect to the online database
         check into the child nodes - then into the user's specific note
         collect the information into an NSDictionary (dictionary) and
         used to set the variables to the values that are inside the dictionary
         */
        
        var ref: DatabaseReference! //get a reference
        ref = Database.database().reference() //set the reference
        let userID = Auth.auth().currentUser?.uid //get the user's ID
        ref.child("user").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let gold = value?["gold reward"] as? Int ?? 0
            let silver = value?["silver reward"] as? Int ?? 0
            let bronze = value?["bronze reward"] as? Int ?? 0
            let total = value?["total"] as? Int ?? 0
            //set the gathered data to variables
            self.bronze = bronze
            self.silver = silver
            self.gold = gold
            
        }) { (error) in
            //if an error is detected, print it to the console - when using the app this will never show
            print(error.localizedDescription)
        }
    }
    
    func checkIfNewDay(completion: @escaping (_ isNew: Bool) -> Void) {
        /*
         This function is used to compare the current date to the last
         one which is saved into the database - this is used to be able
         to check if it is a new day so that the daily can reset if so
         */
        print(self.currDate)
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("user").child(userID!).child("challenge").child("dates").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print("inside function")
            let value = snapshot.value as? NSDictionary
            self.lastDate = value?["lastSaveDate"] as? String ?? "Date Invalid"
            self.newLastDate = String(self.lastDate)
            if self.newLastDate != "Date Invalid" { //This is used to be able to test if there is a valid date
                print(self.lastDate)
                if (self.newLastDate == self.currentDate) {
                    print("It's not the next day")
                    completion(false)
                } else {
                    print("It's the next day reset to start")
                    completion(true)
                }
            } else { //If there is an error, set the current data to the database
                print("Error, date not able to be recieved from the database")
                self.catchGetDateError = true
                self.saveCurrentDate()
                completion(false)
            }
        })
    }
    
    func giveRewardsAndSetScoresToZero() {
        /*
         Set the scores to zero and give the appropriate score
         to the database so that they add to the totals, and the
         scores are reset to begin the next day - should only run when compleition is true
         */
        var giveBronze: Int = 0
        var giveSilver: Int = 0
        var giveGold: Int = 0
        
        //Check the amount of situps
        print(self.situpNumberVule)
        if (self.situpNumberVule >= 30) && (self.situpNumberVule < 60) { // if between 25 .. 50
            giveBronze += 1
        } else if (self.situpNumberVule >= 60) && (self.situpNumberVule < 90) { // if between 50 .. 75
            giveSilver += 1
        } else if (self.situpNumberVule >= 90) && (self.situpNumberVule <= 100) {// if between 75 .. 100
            giveGold += 1
        } else { // if between 0 .. 25
            print("Rewards not avaliable under 30.")
        }
        
        //Check the amount of pressups
        if (self.squatNumberVule >= 30) && (self.squatNumberVule < 60) {
            giveBronze += 1
        } else if (self.squatNumberVule >= 60) && (self.squatNumberVule < 90) {
            giveSilver += 1
        } else if (self.squatNumberVule >= 90) && (self.squatNumberVule <= 100) {
            giveGold += 1
        } else {
            print("Rewards not avaliable under 30.")
        }
        
        //Check the amount of star jumps
        if (self.lungeNumberVule >= 30) && (self.lungeNumberVule < 60) {
            giveBronze += 1
        } else if (self.lungeNumberVule >= 60) && (self.lungeNumberVule < 90) {
            giveSilver += 1
        } else if (self.lungeNumberVule >= 90) && (self.lungeNumberVule <= 100) {
            giveGold += 1
        } else {
            print("Rewards not avaliable under 30.")
        }
        
        savedChangesText.text = "Completed! Come back and restart. Well done! 👏🏻"
        
        let currentAmounts = getCurrentReward()
        print("Bronze: \(self.bronze)")
        print(giveBronze)
        var newBronze: Int = self.bronze + giveBronze
        var newSilver: Int = self.silver + giveSilver // add the current medals + new medals
        var newGold: Int = self.gold + giveGold
        print("Here are the new value:\n__\(newBronze)")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let user = Auth.auth().currentUser!.uid
        let key = ref.child("user").child(user).child("challenge").child("dates")
        ref.child("user/\(user)/challenge/\(getDate())/rewards/bronze reward").setValue(newBronze)
        ref.child("user/\(user)/challenge/\(getDate())/rewards/silver reward").setValue(newSilver) // put the new scores into the database
        ref.child("user/\(user)/challenge/\(getDate())/rewards/gold reward").setValue(newGold)
        
        //sets to zero
        resetExercisesToZero() // set everything to zero
        
    }
    
    
    @IBOutlet weak var NextDay: UIButton!
    @IBAction func NextDayButton(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let user = Auth.auth().currentUser!.uid
        ref.child("user/\(user)/challenge/dates/lastSaveDate").setValue("1/1/1970")
        savedChangesText.text = "Submitted, come back to check rewards!🏆"
    }
    
    func saveCurrentDate() {
        /*
         Saves the current date to the database so that if the user returns
         they will not constantly be seen as a new day user
         */
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let user = Auth.auth().currentUser!.uid
        print(getCurrentDate())
        ref.child("user/\(user)/challenge/dates/lastSaveDate").setValue(getCurrentDate())
    }
    
    func resetExercisesToZero() {
        /*
         sets the scores to zero on the screen then
         runs the function which pushes them to the screen
         */
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let user = Auth.auth().currentUser!.uid
        print("Resetting the exercises to zero.")
        ref.child("user/\(user)/challenge/\(getDate())/squat").setValue(0)
        ref.child("user/\(user)/challenge/\(getDate())/situp").setValue(0)
        ref.child("user/\(user)/challenge/\(getDate())/lunge").setValue(0)
        getSitUpValue() //make everything load again.
    }
    
    func getCurrentDate() -> String {
        /*
         Returns the current date as a string
         in the format "dd/mm/yyyy"
         */
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component (.day, from: date)
        
        let newDate:String = ("\(day)/\(month)/\(year)")
        
        return newDate
    }
    
    //Addition and Minus Buttons Outlets
    @IBOutlet weak var situpAddition: UIButton!
    @IBOutlet weak var situpMinus: UIButton!
    @IBOutlet weak var squatAddition: UIButton!
    @IBOutlet weak var squatMinus: UIButton!
    @IBOutlet weak var lungeAddition: UIButton!
    @IBOutlet weak var lungeMinus: UIButton!
    
    
    //Navigation Bar Outlets
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
    @IBAction func editButtonFunction(_ sender: Any) {
        //This is a complex function which will be in three parts
        
        //First part - change the title of the button
        changeEditButtonText()
        
        //Second part - enabling the plus and minus buttons if edit is pressed
        if !checkIfButtonIsEdit() {
            //This will be inverted, so using ! will ask for the not value - negating the effect
            enableTheButtons()
        } else {
            disableTheButtons()
        }
        
    }
    
    func enableTheButtons() { //enable all six of the buttons
        self.situpAddition.isEnabled = true
        self.situpMinus.isEnabled = true
        self.squatAddition.isEnabled = true
        self.squatMinus.isEnabled = true
        self.lungeAddition.isEnabled = true
        self.lungeMinus.isEnabled = true
    }
    
    func disableTheButtons() { //disable all six of the buttons
        self.situpAddition.isEnabled = false
        self.situpMinus.isEnabled = false
        self.squatAddition.isEnabled = false
        self.squatMinus.isEnabled = false
        self.lungeAddition.isEnabled = false
        self.lungeMinus.isEnabled = false
    }
    
    
    func changeEditButtonText() {
        //Changes the edit button title between two states.
        if checkIfButtonIsEdit() {
            self.editButton.title = "Save Changes"
        } else {
            self.editButton.title = "Edit"
        }
    }
    
    func checkIfButtonIsEdit() -> Bool {
        currentState = !currentState
        return !currentState
    }
    
    func getSitUpValue() {
        /*
         Gets the three current scores from the database
         and sets them into variables which can be used
         and also sets the labels to the current variables
         */
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("user").child(userID!).child("challenge").child(getDate()).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let situp:Int = value?["situp"] as? Int ?? 0
            let squat:Int = value?["squat"] as? Int ?? 0
            let lunge:Int = value?["lunge"] as? Int ?? 0
            self.situpNumberVule = situp
            self.squatNumberVule = squat
            self.lungeNumberVule = lunge
            self.situpValue.text = ("\(self.situpNumberVule) / 100")
            self.squatValue.text = ("\(self.squatNumberVule) / 100")
            self.lungeValue.text = ("\(self.lungeNumberVule) / 100")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        //var changesWereASuccess = false
        /*
         Saves the current values to the database
         */
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let user = Auth.auth().currentUser!.uid
        let key = ref.child("user").child(user).child("challenge").child(getDate())
        ref.child("user/\(user)/challenge/\(getDate())/situp").setValue(self.situpNumberVule)
        ref.child("user/\(user)/challenge/\(getDate())/squat").setValue(self.squatNumberVule)
        ref.child("user/\(user)/challenge/\(getDate())/lunge").setValue(self.lungeNumberVule)
        
    }
    func getDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        // hours + min:  -\(calendar.component(.hour, from: date))-\(calendar.component(.minute, from: date))
        return "\(calendar.component(.year, from: date))-\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))"
        
    }
    
    
    @IBOutlet weak var savedChangesText: UITextField!
    
    //Outlets
    @IBOutlet weak var situpValue: UILabel!
    
    //Functions
    @IBAction func situpPlusValue(_ sender: Any) {
        if (self.situpNumberVule < 100) {
            self.situpNumberVule += 1
            self.situpValue.text = ("\(situpNumberVule) / 100")
        }
    }
    
    @IBAction func situpMinusValue(_ sender: Any) {
        if (self.situpNumberVule > 0) {
            self.situpNumberVule -= 1
            self.situpValue.text = ("\(situpNumberVule) / 100")
        }
        
    }
    
    @IBAction func squatPlusValue(_ sender: Any) {
        if (self.squatNumberVule < 100) {
            self.squatNumberVule += 1
            self.squatValue.text = ("\(self.squatNumberVule) / 100")
        }
    }
    
    @IBAction func squatMinusValue(_ sender: Any) {
        if (self.squatNumberVule > 0) {
            self.squatNumberVule -= 1
            self.squatValue.text = ("\(self.squatNumberVule) / 100")
            
        }
    }
    
    @IBAction func lungePlusValue(_ sender: Any) {
        if (self.lungeNumberVule < 100) {
            self.lungeNumberVule += 1
            self.lungeValue.text = ("\(self.lungeNumberVule) / 100")
        }
    }
    
    @IBAction func lungeMinusValue(_ sender: Any) {
        if (self.lungeNumberVule > 0) {
            self.lungeNumberVule -= 1
            self.lungeValue.text = ("\(self.lungeNumberVule) / 100")
        }
    }
    
    @IBAction func updateDay(_ sender: Any) { //when the update button is pressed, run this
        saveCurrentDate()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //when the screen first appears, run this function line by line
        
        getSitUpValue()
        getCurrentReward()
        
        checkIfNewDay(completion: { isNew in
            if isNew {
                self.savedChangesText.text = "Please press update day"
                self.giveRewardsAndSetScoresToZero()
            } else {
                print("is not a new day.")
                self.savedChangesText.text = ""
            }
        })
        
        
        
        self.currentDate = getCurrentDate()
        print(self.currentDate)
        print(self.getCurrentDate())
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}
