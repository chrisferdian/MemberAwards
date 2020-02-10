//
//  WelcomeViewController.swift
//  MemberAwards
//
//  Created by Chris Ferdian on 08/02/20.
//  Copyright © 2020 Chrizers. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var fieldEamil: UITextField!
    var viewModel: WelcomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }

    private func setupViewModel() {
        viewModel = WelcomeViewModel()
        viewModel?.didSignIn = { success in
            print(success)
        }
    }
    
    @IBAction func didSignInTapped() {
        guard let email = fieldEamil.text else { return }
        viewModel?.handleSignIn(email: email)
    }
}
