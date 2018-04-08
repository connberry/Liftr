//  ProfileViewController.swift
//  Liftr2
//  Created by Connor Berry on 10/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase
import MessageUI

class ProfileViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var notes1: UIButton!
    @IBOutlet weak var notes2: UIButton!
    @IBOutlet weak var notes3: UIButton!
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
    
    // Sign user out of firebase
    @IBAction func SignOutButton(_ sender: Any) {
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
        UIApplication.shared.open(URL(string: "https://www.facebook.com/theliftrapp/")! as URL, options: [:], completionHandler: nil)
    }   // Instagram link
    @IBAction func InstagramPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.instagram.com/theliftrapp/")! as URL, options: [:], completionHandler: nil)
    }   // Twitter link
    @IBAction func TwitterPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://twitter.com/theliftrapp")! as URL, options: [:], completionHandler: nil)
    }   // Snapchat link
    @IBAction func SnapchatPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.snapchat.com/add/thelifrapp")! as URL, options: [:], completionHandler: nil)
    }   // Spotify link
    @IBAction func SpotifyPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://open.spotify.com/user/c8z2c365h5uho6hhitbnk3fq2?si=NKBcLgXGSuGZ2FbBOqqMuw")! as URL, options: [:], completionHandler: nil)
    }

}
