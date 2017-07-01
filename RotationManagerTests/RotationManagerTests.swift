//
//  RotationManagerTests.swift
//  RotationManagerTests
//
//  Created by Derrick Ho on 6/30/17.
//  Copyright © 2017 Derrick Ho. All rights reserved.
//

import XCTest
@testable import RotationManager

class MockViewController: UIViewController, RotationSubscriber {
    
    var rotationEnabled: Bool = false
    
    deinit {
        print(#function, "MockViewController")
    }
}

class RotationManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let rm = RotationManager.shared
        XCTAssertEqual(rm.currentRotationMask, RotationMaskRules().whenLocked)
        
        
        let vc = MockViewController()
        rm.subscribe(vc)
        
        XCTAssertEqual(rm.currentRotationMask, RotationMaskRules().whenLocked)
        
        do {
            let vc = MockViewController()
            vc.rotationEnabled = true
            rm.subscribe(vc)
            
            XCTAssertEqual(rm.currentRotationMask, RotationMaskRules().whenUnlocked)
        }
        XCTAssertEqual(rm.currentRotationMask, RotationMaskRules().whenLocked)
        vc.rotationEnabled = true
        XCTAssertEqual(rm.currentRotationMask, RotationMaskRules().whenUnlocked)
        vc.rotationEnabled = false
        XCTAssertEqual(rm.currentRotationMask, RotationMaskRules().whenLocked)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
