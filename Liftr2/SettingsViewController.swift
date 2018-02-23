//
//  SettingsViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 20/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    
    let images = [""]
    
    
    @IBAction func ImportProfileImage(_ sender: Any) {
        
        let ImagePickerController = UIImagePickerController()
        ImagePickerController.delegate = self
        
        let actionSheet = UIAlertController (title: "Photo Source", message: "Choose Source", preferredStyle: . actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera)   {
            } else
            {print("Camera Not Avalaible")
                
            }
            ImagePickerController.sourceType = .camera
            self.present(ImagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in ImagePickerController.sourceType = .photoLibrary
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
        
        let img = UIImage(named: "Navigation Bar.png")
        navigationController?.navigationBar.barTintColor = UIColor(patternImage: img!)

        ProfileImageView.layer.cornerRadius = ProfileImageView.frame.size.width/2
        ProfileImageView.clipsToBounds = true
        ProfileImageView.image = UIImage.init(named: images[0])
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
