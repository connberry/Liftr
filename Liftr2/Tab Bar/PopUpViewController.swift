//
//  PopUpViewController.swift
//  Liftr2
//
//  Created by Connor Berry on 26/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    
     @IBOutlet weak var Close: UIButton!
    @IBOutlet weak var Go: UIButton!

    @IBAction func closePop(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Close.layer.cornerRadius = 30.0
        
        self.view.backgroundColor = UIColor.white

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse, .curveEaseOut], animations: {
        self.Go.alpha = 0.0
    
    }, completion: nil)
}
}
