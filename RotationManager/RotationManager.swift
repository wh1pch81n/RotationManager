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
    var rotationEnabled: Bool { get }
}

extension RotationSubscriber {
    public var rotationEnabled: Bool { return false }
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

