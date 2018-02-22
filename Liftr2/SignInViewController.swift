//
//  SignInViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 09/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit
import AVFoundation

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    
    @IBOutlet weak var EmailAddressTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
        //Start of hide keyboard
        self.EmailAddressTextField.delegate = self
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
        EmailAddressTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func SignInButtonTapped(_ sender: Any) {
        print("Sign In Button Tapped")
    }
    
    @IBAction func SignUpButtonTapped(_ sender: Any) {
        print("Register Account Button Tapped")
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    }
}
