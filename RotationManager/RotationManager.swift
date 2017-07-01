//
//  RotationManager.swift
//  RotationManager
//
//  Created by Derrick Ho on 6/30/17.
//  Copyright © 2017 Derrick Ho. All rights reserved.
//

import UIKit

/// Protocol that grants an object
public protocol RotationSubscriber {
    var rotationEnabled: Bool { get set }
}

extension RotationSubscriber {
    var rotationEnabled: Bool { return false }
}

/// This object holds a weak pointer to a RotationScriber Object.
public struct WeakRotationObject {
    fileprivate weak var vc: (UIViewController & RotationSubscriber)?
    
    fileprivate init(_ subscriber: UIViewController & RotationSubscriber) {
        self.vc = subscriber
    }
}

/// A class responsible for managing Rotation masks.  Override methods to change behavior
public protocol RotationMaskRules {
    var whenUnlocked: UIInterfaceOrientationMask { get }
    var whenLocked: UIInterfaceOrientationMask { get }
}

extension RotationMaskRules {
    public var whenUnlocked: UIInterfaceOrientationMask { return .allButUpsideDown }
    public var whenLocked: UIInterfaceOrientationMask { return .portrait }
}

//public struct DefaultRotationRules: RotationMaskRules {}

/// This class determines if rotation should be allowed. Override to change behavior
public protocol RotationRule {
    var rotationManager: RotationManager { get }
    var rotationEnabled: Bool { get }
}

extension RotationRule {
    public var rotationManager: RotationManager { return RotationManager.shared }
    public var rotationEnabled: Bool {
        let s = rotationManager.subscribers
            .filter({ $0.vc?.rotationEnabled == true })
        return s.isEmpty == false
    }
}

//extension DefaultRotationRules: RotationRule {}

extension RotationManager: RotationRule, RotationMaskRules {}

/// A class that manages rotation logic.
public class RotationManager {
    // MARK: private properties
    
    /// An array that holds all the Rotation subscribers
    public private(set) var subscribers = [WeakRotationObject]()
    
    // MARK: public properties
    
    /// Shared instance
    public static let shared = RotationManager()
    
    /// This object determines what masks to use when locked or unlocked
    public lazy var rotationMaskRule: RotationMaskRules = self // DefaultRotationRules()
    
    /// This object determines the rules regarding rotation
    public lazy var rotationRule: RotationRule = self //DefaultRotationRules()
    
    /// Retrieve the current rotation mask
    public var currentRotationMask: UIInterfaceOrientationMask {
        flush()
        //let rule = rotationRule.rotationEnabled ? \RotationMaskRules.whenUnlocked : \.whenLocked
        //return rotationMaskRule[keyPath: rule]
        return rotationRule.rotationEnabled ? rotationMaskRule.whenUnlocked : rotationMaskRule.whenLocked
    }
    
    /// subscribed objects are elligible to control the rotation
    public func subscribe(_ subscriber: UIViewController & RotationSubscriber) {
        subscribers.append(WeakRotationObject(subscriber))
    }
    
}

// MARK: RotationManager private methods

extension RotationManager {
    private func flush() {
        subscribers = subscribers.filter({ $0.vc != nil  })
    }
}
