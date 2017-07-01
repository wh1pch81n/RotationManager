//
//  AppDelegate.swift
//  RotationManager
//
//  Created by Derrick Ho on 6/30/17.
//  Copyright © 2017 Derrick Ho. All rights reserved.
//

import UIKit

public protocol RotationSubscriber: class {
    var rotationEnabled: Bool { get set }
}

extension RotationSubscriber {
    var rotationEnabled: Bool { return false }
}

/// A class responsible for managing Rotation masks.  Override methods to change behavior
open class RotationMaskRules {
    open var whenUnlocked: UIInterfaceOrientationMask { return .allButUpsideDown }
    open var whenLocked: UIInterfaceOrientationMask { return .portrait }
}

/// This class determines if rotation should be allowed. Override to change behavior
open class DefaultRotationRule {
    lazy var rotationManager = RotationManager.shared

    open var rotationEnabled: Bool {
        let s = rotationManager.subscribers
            .filter({ $0.vc?.rotationEnabled == true })
        return s.isEmpty == false
    }
}

/// A class that manages rotation logic.
public class RotationManager {
    // MARK: private properties
    
    /// An array that holds all the Rotation subscribers
    public private(set) var subscribers = [WeakRotationObject]()
    
    // MARK: public properties
    
    /// Shared instance
    public static let shared = RotationManager()
    
    /// This object determines what masks to use when locked or unlocked
    public var rotationMaskRule = RotationMaskRules()
    
    /// This object determines the rules regarding rotation
    public var rotationRule = DefaultRotationRule()
    
    /// Retrieve the current rotation mask
    public var currentRotationMask: UIInterfaceOrientationMask {
        flush()
        
//         return (rotationEnabled ? \RotationMaskRules.whenUnlocked : .whenLocked)
        return rotationRule.rotationEnabled
            ? rotationMaskRule.whenUnlocked
            : rotationMaskRule.whenLocked
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

public struct WeakRotationObject {
    fileprivate weak var vc: (UIViewController & RotationSubscriber)?
    
    fileprivate init(_ subscriber: UIViewController & RotationSubscriber) {
        self.vc = subscriber
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return RotationManager.shared.currentRotationMask
    }

}

