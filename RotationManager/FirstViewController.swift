//
//  FirstViewController.swift
//  RotationManager
//
//  Created by Derrick Ho on 6/30/17.
//  Copyright © 2017 Derrick Ho. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, RotationSubscriber {
    
    var rotationEnabled: Bool = false
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        rotationEnabled = sender.isOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RotationManager.shared.subscribe(self)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

