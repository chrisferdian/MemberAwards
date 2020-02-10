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
        viewModel?.didSignIn = { response in
            guard let application = UIApplication.shared.delegate as? AppDelegate else { return }
            if response.success ?? false {
                let myViewController = FeedViewController(nibName: "FeedViewController", bundle: nil)
                let feedViewController = UINavigationController(rootViewController: myViewController)
                application.window?.setRootViewController(feedViewController, options: .init(direction: .fade, style: .easeIn))
                
            }
        }
    }
    
    @IBAction func didSignInTapped() {
        guard let email = fieldEamil.text else { return }
        let req = WelcomeModel.Request(email: email)
        viewModel?.handleSignIn(request: req)
    }
}
