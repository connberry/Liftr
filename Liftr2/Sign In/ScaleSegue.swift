//  ScaleSegue.swift
//  Liftr2
//  Created by Connor Berry on 08/04/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit

class ScaleSegue: UIStoryboardSegue {
    
    // Beginning of scale segue
    override func perform() {
        scale()
    }
    // Scale function
    func scale () {
        let toView = self.destination
        let fromView = self.source
        let containerView = fromView.view.superview
        let orginalCenter = fromView.view.center
    // Transformation
        toView.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toView.view.center = orginalCenter
        containerView?.addSubview(toView.view)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {toView.view.transform = CGAffineTransform.identity }, completion: { success in
            fromView.present(toView, animated: false, completion: nil)
            
        })
    }
}
