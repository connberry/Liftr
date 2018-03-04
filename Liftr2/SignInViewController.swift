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

    
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

}
}
