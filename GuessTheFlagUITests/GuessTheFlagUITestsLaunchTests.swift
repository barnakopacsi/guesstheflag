//
//  GuessTheFlagUITestsLaunchTests.swift
//  GuessTheFlagUITests
//
//  Created by Kopácsi Barna Martin on 2025. 05. 04..
//
// Copyright © 2025 [Kopácsi Barna Martin]. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License.
// You may not use this material for commercial purposes without obtaining permission from the author.
//

import XCTest

final class GuessTheFlagUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
