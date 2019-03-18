//
//  chuckthemonkUITests.swift
//  chuckthemonkUITests
//
//  Created by Gary O'Donoghue on 16/01/2019.
//  Copyright © 2019 Gary O'Donoghue. All rights reserved.
//

import FBSnapshotTestCase
import XCTest
@testable import chuckthemonk

class chuckthemonkUITests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false;
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testMainViewController() {
        let classUnderTest = MainViewController()
        FBSnapshotVerifyView(classUnderTest.view)
    }
    
    func testArchivedViewController() {
        let classUnderTest = ArchivedItemsViewController()
        FBSnapshotVerifyView(classUnderTest.view)
    }
}
