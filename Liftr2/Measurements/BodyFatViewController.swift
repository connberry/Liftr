import UIKit
import Firebase
import NotificationBannerSwift

class BodyFatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Declarations of Database and Added Exercise
    var addCalc = [Calc]()
    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    
    @IBOutlet weak var tableView: UITableView!
    
    // Table returns number of exercises
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addCalc.count
    }
    // Cell textLabel equals exercise entered
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCustomTableViewCell1
        let test = addCalc[indexPath.row]
        cell.calc.text = test.calc
        cell.subtitle.text = "%"
        cell.date.text = test.date
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Database Reference
        ref = Database.database().reference()
        
        // Adds notes child
        handle = ref?.child("user").child(Auth.auth().currentUser!.uid).child("measurements").child("calculations").child("bodyfat %").observe(.childAdded, with: { (snapshot) in
            let results = snapshot.value as? [String : AnyObject]
            let calc = results?["bodyfat %"]
            let date = results?["date"]
            let data = Calc(calc: calc as! String?, date: date as! String?)
            self.addCalc.append(data)
            self.tableView.reloadData() })
    }
    
    func getDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        // hours + min:  -\(calendar.component(.hour, from: date))-\(calendar.component(.minute, from: date))
        return "\(calendar.component(.year, from: date))-\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let test = addCalc[indexPath.row]
        let myString1 = test.calc
        let myInt1 = Double(myString1!)
        if myInt1! > 5 && myInt1! < 12 {
            let banner = NotificationBanner(title: "Essential Body Fats❗️", subtitle: "It is recommended you visit your GP immediately", style: .danger)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 12.1 && myInt1! < 20.9 {
            let banner = NotificationBanner(title: "Athlete ✅", subtitle: "You have an athletic build!", style: .success)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 21 && myInt1! < 24 {
            let banner = NotificationBanner(title: "Fitness ✅", subtitle: "Fitness range is perfect for people who lift but are not pro's", style: .success)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 25 && myInt1! < 31 {
            let banner = NotificationBanner(title: "Acceptable ⚠️", subtitle: "Try exercising more to lose that body fat %", style: .warning)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 31.1 && myInt1! < 60 {
            let banner = NotificationBanner(title: "Obese ❗️", subtitle: "Contact your GP for advice because your health could be in danger.", style: .danger)
            banner.show(queuePosition: .front)
        }
}
}
