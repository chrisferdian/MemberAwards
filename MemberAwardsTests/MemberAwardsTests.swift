//
//  MemberAwardsTests.swift
//  MemberAwardsTests
//
//  Created by Chris Ferdian on 08/02/20.
//  Copyright © 2020 Chrizers. All rights reserved.
//

import XCTest
@testable import MemberAwards

class MemberAwardsTests: XCTestCase {
    
    /// Properties
    var welcomeViewModel: WelcomeViewModel?
    var constant: Constant?
    
    override func setUp() {
        welcomeViewModel = WelcomeViewModel()
        constant = Constant()
    }

    override func tearDown() {
        self.welcomeViewModel = nil
        self.constant = nil
    }
    
    func testMatchingEmail() {
        let emailFilled = "unknown@mail.com"
        XCTAssertFalse(Constant.emailRegistered.contains(emailFilled))
    }
    
    func testRegistredEmail() {
        let emailFilled = "person@member.id"
        XCTAssertTrue(Constant.emailRegistered.contains(emailFilled))
    }
}
