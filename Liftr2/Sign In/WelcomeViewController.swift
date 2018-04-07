//  SignInViewController.swift
//  Liftr2
//  Created by Connor Berry on 09/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit
import AVFoundation
import Firebase

class WelcomeViewController: UIViewController, UITextFieldDelegate {

    // Storyboard connections
    @IBOutlet weak var LiftrLogo: UIImageView!
    @IBOutlet weak var LogInImage: UIImageView!
    @IBOutlet weak var Sentence1: UILabel!
    @IBOutlet weak var Sentence2: UILabel!
    @IBOutlet weak var Sentence3: UILabel!
    @IBOutlet weak var Sentence4: UILabel!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var SignInText: UILabel!
    
    // Video background declaration
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Makes storyboard items invisible for animations
    LiftrLogo.alpha = 0
    LogInImage.alpha = 0
    Sentence1.alpha = 0
    Sentence2.alpha = 0
    Sentence3.alpha = 0
    Sentence4.alpha = 0
    SignInButton.alpha = 0
    SignInText.alpha = 0
     
    // Allows video to be played in the background named Video
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
    // Do additional tasks associated with presenting the view
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
    // Once signed in user goes straight to Profile
    if Auth.auth().currentUser != nil {
    self.performSegue(withIdentifier: "logged", sender: self)
        }
        
    // Nested animation of storyboard items
    // Liftr Logo
    UIView.animate(withDuration: 1, animations: {
    self.LiftrLogo.alpha = 1 }) { (true) in self.showLogIn() }
}
    // Log In Box
    func showLogIn() {
    UIView.animate(withDuration: 1, animations: { self.LogInImage.alpha = 1 }, completion: { (true) in self.sent1() })
}
    // Sentence 1
    func sent1() {
    UIView.animate(withDuration: 1, animations: { self.Sentence1.alpha = 1 }, completion: { (true) in self.sent2() })
}
    // Sentence 2
    func sent2() {
    UIView.animate(withDuration: 1, animations: { self.Sentence2.alpha = 1 }, completion: { (true) in self.sent3() })
}
    // Sentence 3
    func sent3() {
    UIView.animate(withDuration: 1, animations: { self.Sentence3.alpha = 1 }, completion: { (true) in self.sent4() })
}
    // Sentence 4
    func sent4() {
    UIView.animate(withDuration: 1, animations: { self.Sentence4.alpha = 1 }, completion: { (true) in self.LogButton() })
}
    // Log In Button
    func LogButton() {
    UIView.animate(withDuration: 1, animations: { self.SignInButton.alpha = 1 }, completion: { (true) in self.LogText() })
}
    // Log In Text
    func LogText() {
    UIView.animate(withDuration: 1, animations: { self.SignInText.alpha = 1 }, completion: { (true) in })
}

}
