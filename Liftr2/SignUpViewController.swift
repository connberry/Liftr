//
//  SignUpViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 10/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit
import AVFoundation

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!

    //Link text fields to this code
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var EmailAddressTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RepeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Start of hide keyboard
        self.FirstNameTextField.delegate = self
        
        
        let URL = Bundle.main.url(forResource: "Video", withExtension: "mp4")
        
        Player = AVPlayer.init(url: URL!)
        
        PlayerLayer = AVPlayerLayer(player: Player)
        PlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        PlayerLayer.frame = view.layer.frame
        
        Player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        
        Player.play()
        view.layer.insertSublayer(PlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.Player.currentItem, queue: .main) { _ in
            self.Player?.seek(to: kCMTimeZero)
            self.Player?.play()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        FirstNameTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func CancelButtonTapped(_ sender: Any) {
        print("Cancel Button Tapped")
    
    //Return to Sign In page
    self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SignUpButtonTapped(_ sender: Any) {
        print("Sign Up Button Tapped")
    }
}
