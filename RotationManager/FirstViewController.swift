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
    var switchView: UISwitch?
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        switchView = sender
        rotationEnabled = sender.isOn
    }
    
    @IBAction func tappedButton(_ sender: Any) {
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RotationManager.shared.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        switchView?.isOn = false
//        if rotationEnabled {
            // works to force orientation check but it is flickery
//            let vc = UIViewController()
//            DispatchQueue.main.async {
//                self.present(vc, animated: false) {
//                    vc.dismiss(animated: false, completion: nil)
//                }
//            }
//        }
        rotationEnabled = false
        
        super.viewWillDisappear(animated)
    }
}

