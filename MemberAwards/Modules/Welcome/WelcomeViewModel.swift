//
//  WelcomeViewModel.swift
//  MemberAwards
//
//  Created by Chris Ferdian on 10/02/20.
//  Copyright © 2020 Chrizers. All rights reserved.
//

import Foundation

class WelcomeViewModel {
        
    internal var didSignIn: ((WelcomeModel.Response)->Void)?

    func handleSignIn(request: WelcomeModel.Request) {
        guard let email = request.email else { return }
        if Constant.emailRegistered.contains(email) {
            self.didSignIn?(WelcomeModel.Response(success: true))
        } else {
            self.didSignIn?(WelcomeModel.Response(success: false))
        }
    }
}
