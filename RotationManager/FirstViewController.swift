//
//  FirstViewController.swift
//  RotationManager
//
//  Created by Derrick Ho on 6/30/17.
//  Copyright © 2017 Derrick Ho. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
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
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapped)))
    }
    
    @objc func tapped() {
        dismiss(animated: true) {}
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        switchView?.isOn = false
        rotationEnabled = false
        super.viewWillDisappear(animated)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        switchView?.isOn = false
        rotationEnabled = false
        super.dismiss(animated: flag, completion: completion)
    }
}

extension FirstViewController: RotationSubscriber, RotationMaskRules {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        let mask = presentedViewController?.supportedInterfaceOrientations
            ?? (rotationEnabled ? whenUnlocked : whenLocked)
        print(#function, mask)
        return mask
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let newCollection = self.traitCollection
        switch (newCollection.horizontalSizeClass, newCollection.verticalSizeClass) {
        case (_, UIUserInterfaceSizeClass.compact):
            self.navigationController?.isNavigationBarHidden = true
            self.tabBarController?.tabBar.isHidden = true
        default:
            self.navigationController?.isNavigationBarHidden = false
            self.tabBarController?.tabBar.isHidden = false
        }
    }
}

extension UITabBarController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        let mask = presentedViewController?.supportedInterfaceOrientations
            ?? (viewControllers ?? []).reduce(UIInterfaceOrientationMask(rawValue: 0), { (r, vc) in
                return [r, vc.supportedInterfaceOrientations]
            })
        print(#function, mask)
        return mask
    }
}

extension UINavigationController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        let mask = presentedViewController?.supportedInterfaceOrientations
            ?? viewControllers.reduce(UIInterfaceOrientationMask(rawValue: 0), { (r, vc) in
                return [r, vc.supportedInterfaceOrientations]
            })
        print(#function, mask)
        return mask
    }
}


