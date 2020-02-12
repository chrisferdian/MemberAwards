//
//  WelcomeViewController.swift
//  MemberAwards
//
//  Created by Chris Ferdian on 08/02/20.
//  Copyright © 2020 Chrizers. All rights reserved.
//

import UIKit
import ZKDrawerController

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
            if response.success ?? false {
                self.navigateToFeed()
            }
        }
    }
    
    @IBAction func didSignInTapped() {
        guard let email = fieldEamil.text else { return }
        let req = WelcomeModel.Request(email: email)
        viewModel?.handleSignIn(request: req)
    }
    
    private func navigateToFeed() {
        guard let application = UIApplication.shared.delegate as? AppDelegate else { return }
        let menuController = MenuViewController()
        let feed = UINavigationController(rootViewController: FeedViewController())
        let drawerController = ZKDrawerController(center: feed, left: menuController)
        drawerController.drawerStyle = .cover
        drawerController.mainCoverView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)

        application.window?.setRootViewController(drawerController, options: .init(direction: .fade, style: .easeIn))
    }
}
