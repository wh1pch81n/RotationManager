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
        //RotationManager.shared.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        switchView?.isOn = false
        rotationEnabled = false
        super.viewWillDisappear(animated)
    }
}

extension FirstViewController: RotationMaskRules {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return rotationEnabled ? whenUnlocked : whenLocked
    }
}

extension UITabBarController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return (viewControllers ?? []).reduce(UIInterfaceOrientationMask(rawValue: 0), { (r, vc) in
            return [r, vc.supportedInterfaceOrientations]
        })
    }
}

extension UINavigationController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return viewControllers.reduce(UIInterfaceOrientationMask(rawValue: 0), { (r, vc) in
            return [r, vc.supportedInterfaceOrientations]
        })
    }
}


