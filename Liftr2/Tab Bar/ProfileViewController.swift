//  ProfileViewController.swift
//  Liftr2
//  Created by Connor Berry on 10/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase
import MessageUI
import NotificationBannerSwift

class ProfileViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var exerTextField1: UITextField?
    var exerTextField2: UITextField?
    var exerTextField3: UITextField?
    var ref: DatabaseReference!
    
    
    @IBOutlet weak var notes1: UIButton!
    @IBOutlet weak var not1: UILabel!
    @IBAction func name1(_ sender: Any) {
        if exerTextField1?.text != "" {
            ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes names").updateChildValues(["notes 1": self.exerTextField1?.text])
        }
       let alertController = UIAlertController(title: "Change Workout Name", message: "Change the name of your workout, then confirm by clicking the tick button", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Confirm", style: .default, handler: { action in
            self.not1.text = self.exerTextField1?.text
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addTextField { (textField) -> Void in
        self.exerTextField1 = textField
        self.exerTextField1?.placeholder = "Type Workout Name"
        }
        alertController.addAction(ok)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func conf1(_ sender: Any) {
        let banner = NotificationBanner(title: "Success, Workout Name Saved 🏋️‍♀️", style: .success)
        banner.show()
        if exerTextField1?.text != "" {
            ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes names").updateChildValues(["notes 1": self.exerTextField1?.text])
        }
    }
    
    @IBOutlet weak var notes2: UIButton!
    @IBOutlet weak var not2: UILabel!
    @IBAction func name2(_ sender: Any) {
        if exerTextField2?.text != "" {
            ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes names").updateChildValues(["notes 2": self.exerTextField2?.text])
        }
        let alertController = UIAlertController(title: "Change Workout Name", message: "Change the name of your workout, then confirm by clicking the tick button", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Confirm", style: .default, handler: { action in
            self.not2.text = self.exerTextField2?.text
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addTextField { (textField) -> Void in
            self.exerTextField2 = textField
            self.exerTextField2?.placeholder = "Type Workout Name"
        }
        alertController.addAction(ok)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func conf2(_ sender: Any) {
        let banner = NotificationBanner(title: "Success, Workout Name Saved 🏋️‍♀️", style: .success)
        banner.show()
        if exerTextField2?.text != "" {
            ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes names").updateChildValues(["notes 2": self.exerTextField2?.text])
        }
    }
    
    @IBOutlet weak var notes3: UIButton!
    @IBOutlet weak var not3: UILabel!
    @IBAction func name3(_ sender: Any) {
        if exerTextField3?.text != "" {
            ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes names").updateChildValues(["notes 3": self.exerTextField3?.text])
        }
        let alertController = UIAlertController(title: "Change Workout Name", message: "Change the name of your workout, then confirm by clicking the tick button", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Confirm", style: .default, handler: { action in
            self.not3.text = self.exerTextField3?.text
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addTextField { (textField) -> Void in
            self.exerTextField3 = textField
            self.exerTextField3?.placeholder = "Type Workout Name"
        }
        alertController.addAction(ok)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func conf3(_ sender: Any) {
        let banner = NotificationBanner(title: "Success, Workout Name Saved 🏋️‍♀️", style: .success)
        banner.show()
        if exerTextField3?.text != "" {
            ref?.child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes names").updateChildValues(["notes 3": self.exerTextField3?.text])
        }
    }
    
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
         notes1.layer.cornerRadius = 22.0
         notes2.layer.cornerRadius = 22.0
         notes3.layer.cornerRadius = 22.0
        
    // Fetches users first name from Firebase to display as heading
    if Auth.auth().currentUser?.uid != nil {
    Database.database().reference().child("user").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
    if let dict = snapshot.value as? [String: AnyObject] {
    self.navigationItem.title = dict["first name"] as? String
                
                }
            })
}
        if Auth.auth().currentUser?.uid != nil {
            Database.database().reference().child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes names").observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject] {
                    self.not1.text = dict["notes 1"] as? String
                    
                }
            })
        }
        
        if Auth.auth().currentUser?.uid != nil {
            Database.database().reference().child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes names").observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject] {
                    self.not2.text = dict["notes 2"] as? String
                    
                }
            })
        }
        
        if Auth.auth().currentUser?.uid != nil {
            Database.database().reference().child("user").child(Auth.auth().currentUser!.uid).child("workout notes").child("notes names").observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject] {
                    self.not3.text = dict["notes 3"] as? String
                    
                }
            })
        }
        
    }
    
    // Sign user out of firebase
    @IBAction func SignOutButton(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        let firebaseAuth = Auth.auth()
        do { try firebaseAuth.signOut()
        } catch let signOutError as NSError { print ("Error signing out: %@", signOutError) }
        if Auth.auth().currentUser == nil {
            let signOutVC = UIStoryboard(name: "Tab Bar", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
            self.present(signOutVC, animated: true, completion: nil)
        }
    }

    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}
    // When email button is pressed user taken to preset email to Liftr
    @IBAction func EmailPressed(_ sender: Any) {
        let mailComposeViewContorller = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewContorller, animated: true, completion: nil)
        } else {
            showMailError() }}
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["liftr@mail.com"])
        mailComposerVC.setSubject("Liftr Feedback")
        mailComposerVC.setMessageBody("Hey Liftr team...", isHTML: false)
        return mailComposerVC }
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Can't Send", message: "Device doesn't send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil) }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
}
    // Facebook link
    @IBAction func FacebookPressed(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        UIApplication.shared.open(URL(string: "https://www.facebook.com/theliftrapp/")! as URL, options: [:], completionHandler: nil)
    }   // Instagram link
    @IBAction func InstagramPressed(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        UIApplication.shared.open(URL(string: "https://www.instagram.com/theliftrapp/")! as URL, options: [:], completionHandler: nil)
    }   // Twitter link
    @IBAction func TwitterPressed(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        UIApplication.shared.open(URL(string: "https://twitter.com/theliftrapp")! as URL, options: [:], completionHandler: nil)
    }   // Snapchat link
    @IBAction func SnapchatPressed(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        UIApplication.shared.open(URL(string: "https://www.snapchat.com/add/thelifrapp")! as URL, options: [:], completionHandler: nil)
    }   // Spotify link
    @IBAction func SpotifyPressed(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        UIApplication.shared.open(URL(string: "https://open.spotify.com/user/c8z2c365h5uho6hhitbnk3fq2?si=NKBcLgXGSuGZ2FbBOqqMuw")! as URL, options: [:], completionHandler: nil)
    }

}
