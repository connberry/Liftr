//
//  SettingsViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 20/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class SettingsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    
    let images = [""]
    
    
    @IBAction func ImportProfileImage(_ sender: Any) {
        
        let ImagePickerController = UIImagePickerController()
        ImagePickerController.delegate = self
        
        let actionSheet = UIAlertController (title: "Where from 🤷‍♂️?", message: "Snap or choose a photo", preferredStyle: . actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera 📸", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera)   {
            } else
            {print("Camera Not Avalaible 📵")
                
            }
            ImagePickerController.sourceType = .camera
            self.present(ImagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library 📁", style: .default, handler: { (action:UIAlertAction) in ImagePickerController.sourceType = .photoLibrary
            self.present(ImagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        ProfileImageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)

     

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let img = UIImage(named: "Navigation.png")
        navigationController?.navigationBar.barTintColor = UIColor(patternImage: img!)

        ProfileImageView.layer.cornerRadius = ProfileImageView.frame.size.width/2
        ProfileImageView.clipsToBounds = true
        ProfileImageView.image = UIImage.init(named: images[0])
        ProfileImageView.layer.borderColor = UIColor (red: 251/255.5, green: 171/255.5, blue: 236/255.5, alpha: 1).cgColor
    }
    
    
    @IBAction func SignOutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        DataService().Keychain.delete("uid")
        dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func FacebookPressed(_ sender: Any) {
    
    UIApplication.shared.open(URL(string: "https://www.facebook.com/theliftrapp/")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func InstagramPressed(_ sender: Any) {
    
         UIApplication.shared.open(URL(string: "https://www.instagram.com/theliftrapp/")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func TwitterPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://twitter.com/theliftrapp")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func SnapchatPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.snapchat.com/add/thelifrapp")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func SpotifyPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://open.spotify.com/user/c8z2c365h5uho6hhitbnk3fq2?si=NKBcLgXGSuGZ2FbBOqqMuw")! as URL, options: [:], completionHandler: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
