//  SettingsViewController.swift
//  Liftr2
//  Created by Connor Berry on 20/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import Firebase

class SettingsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // Storyboard connections and actionsheets for camera and photo library implementation
    @IBOutlet weak var ProfileImageView: UIImageView!
    let images = [""]
    @IBAction func ImportProfileImage(_ sender: Any) {
    // Picker to choose image source
    let ImagePickerController = UIImagePickerController()
        ImagePickerController.delegate = self
    
    // Title for actionsheet
    let actionSheet = UIAlertController (title: "Where from 🤷‍♂️?", message: "Snap or choose a photo", preferredStyle: . actionSheet)
    // Camera actionsheet
        actionSheet.addAction(UIAlertAction(title: "Camera 📸", style: .default, handler: { (action:UIAlertAction) in
    
    // If any of the sources are not avaliable
    if UIImagePickerController.isSourceTypeAvailable(.camera) { } else { print("Camera Not Avalaible") }
        ImagePickerController.sourceType = .camera
        self.present(ImagePickerController, animated: true, completion: nil) }))
        
    // Photo Library actionsheet
    actionSheet.addAction(UIAlertAction(title: "Photo Library 📁", style: .default, handler: { (action:UIAlertAction) in ImagePickerController.sourceType = .photoLibrary
        self.present(ImagePickerController, animated: true, completion: nil) }))
    // Cancel actionsheet
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
}
    // Selects image from sources
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    ProfileImageView.image = image
    picker.dismiss(animated: true, completion: nil) }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
}
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Navigation bar gradient image
    let img = UIImage(named: "Navigation.png")
    navigationController?.navigationBar.barTintColor = UIColor(patternImage: img!)
    
    // Profile image shape and border colour
    ProfileImageView.layer.cornerRadius = ProfileImageView.frame.size.width/2
    ProfileImageView.clipsToBounds = true
    ProfileImageView.image = UIImage.init(named: images[0])
    ProfileImageView.layer.borderColor = UIColor (red: 251/255.5, green: 171/255.5, blue: 236/255.5, alpha: 1).cgColor
}
    // Sign user out of firebase
    @IBAction func SignOutButton(_ sender: Any) {
    let firebaseAuth = Auth.auth()
    do { try firebaseAuth.signOut() } catch let signOutError as NSError { print ("Error signing out: %@", signOutError) }
    dismiss(animated: true, completion: nil)
}
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
