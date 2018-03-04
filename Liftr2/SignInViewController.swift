//
//  SignInViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 09/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseDatabase
import KeychainSwift

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var LiftrLogo: UIImageView!
    @IBOutlet weak var LogInImage: UIImageView!
    @IBOutlet weak var Sentence1: UILabel!
    @IBOutlet weak var Sentence2: UILabel!
    @IBOutlet weak var Sentence3: UILabel!
    @IBOutlet weak var Sentence4: UILabel!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var SignInText: UILabel!
    
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LiftrLogo.alpha = 0
        LogInImage.alpha = 0
        Sentence1.alpha = 0
        Sentence2.alpha = 0
        Sentence3.alpha = 0
        Sentence4.alpha = 0
        SignInButton.alpha = 0
        SignInText.alpha = 0
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, animations: {
            self.LiftrLogo.alpha = 1
        }) { (true) in
            self.showLogIn()
        }
    }
    func showLogIn() {
    UIView.animate(withDuration: 1, animations: {
    self.LogInImage.alpha = 1
    }, completion: { (true) in
        self.sent1()
    })
    }
        func sent1() {
        UIView.animate(withDuration: 1, animations: {
            self.Sentence1.alpha = 1
        }, completion: { (true) in
            self.sent2()
    })
}
    func sent2() {
        UIView.animate(withDuration: 1, animations: {
            self.Sentence2.alpha = 1
        }, completion: { (true) in
            self.sent3()
            
        })
    }
    func sent3() {
    UIView.animate(withDuration: 1, animations: {
    self.Sentence3.alpha = 1
    }, completion: { (true) in
    self.sent4()
})
}
    func sent4() {
        UIView.animate(withDuration: 1, animations: {
            self.Sentence4.alpha = 1
        }, completion: { (true) in
            self.LogButton()
    })
}
    func LogButton() {
        UIView.animate(withDuration: 1, animations: {
            self.SignInButton.alpha = 1
        }, completion: { (true) in
            self.LogText()
        })
}
    func LogText() {
        UIView.animate(withDuration: 1, animations: {
            self.SignInText.alpha = 1
        }, completion: { (true) in

})
}
}
