//
//  WelcomeViewModel.swift
//  MemberAwards
//
//  Created by Chris Ferdian on 10/02/20.
//  Copyright © 2020 Chrizers. All rights reserved.
//

import Foundation

class WelcomeViewModel {
        
    internal var didSignIn: ((Bool)->Void)?

    func handleSignIn(email: String) {
        if Constant.emailRegistered.contains(email) {
            self.didSignIn?(true)
        } else {
            self.didSignIn?(false)
        }
    }
}
