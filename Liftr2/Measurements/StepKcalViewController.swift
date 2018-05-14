import UIKit
import Firebase
import NotificationBannerSwift

class StepKcalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        cell.subtitle.text = "kcal"
        cell.date.text = test.date
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Database reference
        ref = Database.database().reference()
        
        // Adds notes child
        handle = ref?.child("user").child(Auth.auth().currentUser!.uid).child("measurements").child("calculations").child("kcal").observe(.childAdded, with: { (snapshot) in
            let results = snapshot.value as? [String : AnyObject]
            let calc = results?["kcal"]
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
        if myInt1! > 0 && myInt1! < 100 {
            let banner = NotificationBanner(title: "Not that many kcal...", subtitle: "Walk more to burn the calories!", style: .danger)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 101 && myInt1! < 200 {
             let banner = NotificationBanner(title: "Not that many kcal...", subtitle: "Walk more to burn the calories!", style: .danger)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 201 && myInt1! < 300 {
            let banner = NotificationBanner(title: "Solid effort", subtitle: "Over 200 kcal burned, keep it up!", style: .warning)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 301 && myInt1! < 400 {
            let banner = NotificationBanner(title: "Solid effort", subtitle: "Over 300 kcal burned, keep it up!", style: .success)
            banner.show(queuePosition: .front)
        }
        if myInt1! > 401 && myInt1! < 1000 {
            let banner = NotificationBanner(title: "Amazing", subtitle: "The calories are burning fast!", style: .success)
            banner.show(queuePosition: .front)
        }
    }
}
