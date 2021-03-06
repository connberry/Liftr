import UIKit
import Firebase
import NotificationBannerSwift

class WeightViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    // Declarations of Database and Added Exercise
    var addMes = [Measurement]()
    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    var keyArray: [String] = []
    

    // Storyboard connections
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mesView: UITextField!
    @IBAction func inputButton(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        // Current user insert of exercise
        if mesView.text != "" {
            let dict = (["measure": self.mesView.text!, "date": self.getDate()])
            ref?.child("user").child(Auth.auth().currentUser!.uid).child("measurements").child("weight").child("\(getDate())").setValue(dict)
            mesView.text = ""
            let banner = NotificationBanner(title: "Success, Weight has been saved 🤙", style: .success)
            banner.show()
        }
        else
            // Alert if nothing is entered
            if mesView.text == "" {
                let banner = NotificationBanner(title: "You've Entered Nothing 😳", style: .danger)
                banner.show()
        }
    }
    // Table returns number of exercises
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addMes.count
    }
    // Cell textLabel equals exercise entered
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        let test = addMes[indexPath.row]
        cell.textLabel?.text = test.measure
        cell.detailTextLabel?.text = test.date
        return cell
    }
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mesView.layer.cornerRadius = 15.0
        mesView.frame.origin.y -= view.bounds.width
        
        // Adds target to add measurement type
        mesView.delegate = self
        mesView.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        // Start of hide keyboard
        self.mesView.delegate = self
        
        // Database Reference
        ref = Database.database().reference()
        
        // Adds notes child
        handle = ref?.child("user").child(Auth.auth().currentUser!.uid).child("measurements").child("weight").observe(.childAdded, with: { (snapshot) in
            let results = snapshot.value as? [String : AnyObject]
            let measure = results?["measure"]
            let date = results?["date"]
            let data = Measurement(measure: measure as! String?, date: date as! String?)
            self.addMes.append(data)
            self.tableView.reloadData()
        })
        
    }
    // Adds measurement
    @objc func textFieldDidChange(textfield: UITextField) {
        
        var text = mesView.text?.replacingOccurrences(of: "kg", with: "")
        text = text! + "kg"
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
                self.ref?.child("user").child(Auth.auth().currentUser!.uid).child("measurements").child("weight").child(self.keyArray[indexPath.row]).removeValue()
                let banner = NotificationBanner(title: "Entry deleted! 🗑", style: .danger)
                banner.show()
                self.addMes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.keyArray = []
            })
        }
        
    }
    // Retrieves all keys from Firebase
    func GetAllKeys() {
        ref?.child("user").child(Auth.auth().currentUser!.uid).child("measurements").child("weight").observeSingleEvent(of: .value, with: { (snapshot) in
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
    @IBAction func How(_ sender: Any) { UIApplication.shared.open(URL(string: "https://www.wikihow.com/Measure-Your-Weight-by-Yourself")! as URL, options: [:], completionHandler: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseInOut], animations: {
            self.mesView.frame.origin.y = self.view.bounds.width - 290
        }, completion: nil )}
    
}
