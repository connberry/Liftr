//  WorkoutsViewController.swift
//  Liftr2
//  Created by Connor Berry on 23/02/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.

import UIKit

class MeasurementsViewController: UIViewController {

    var animationHasBeenShown = false
    @IBOutlet weak var weight: UIButton!
    @IBOutlet weak var height: UIButton!
    @IBOutlet weak var waist: UIButton!
    @IBOutlet weak var chest: UIButton!
    @IBOutlet weak var shoulders: UIButton!
    @IBOutlet weak var bicep: UIButton!
    @IBOutlet weak var hips: UIButton!
    @IBOutlet weak var glutes: UIButton!
    @IBOutlet weak var thigh: UIButton!
    @IBOutlet weak var calf: UIButton!

    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        weight.center.x -= view.bounds.width
        height.center.x += view.bounds.width
        waist.center.x -= view.bounds.width
        chest.center.x += view.bounds.width
        shoulders.center.x -= view.bounds.width
        bicep.center.x += view.bounds.width
        hips.center.x -= view.bounds.width
        glutes.center.x += view.bounds.width
        thigh.center.x -= view.bounds.width
        calf.center.x += view.bounds.width
    }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            if !animationHasBeenShown {
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                    self.weight.center.x += self.view.bounds.width
                }, completion: nil)
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                    self.height.center.x -= self.view.bounds.width
                }, completion: nil)
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                    self.waist.center.x += self.view.bounds.width
                }, completion: nil)
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                    self.chest.center.x -= self.view.bounds.width
                }, completion: nil)
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                    self.shoulders.center.x += self.view.bounds.width
                }, completion: nil)
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                    self.bicep.center.x -= self.view.bounds.width
                }, completion: nil)
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                    self.hips.center.x += self.view.bounds.width
                }, completion: nil)
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                    self.glutes.center.x -= self.view.bounds.width
                }, completion: nil)
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                    self.thigh.center.x += self.view.bounds.width
                }, completion: nil)
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                    self.calf.center.x -= self.view.bounds.width
                }, completion: nil)
                
                animationHasBeenShown = true
    
            }
}
}
