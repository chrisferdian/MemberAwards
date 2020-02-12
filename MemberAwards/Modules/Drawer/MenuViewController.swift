//
//  MenuViewController.swift
//  MemberAwards
//
//  Created by Chris Ferdian on 10/02/20.
//  Copyright © 2020 Chrizers. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func hideDrawer() {
        drawerController?.hide(animated: true)
    }
    
    @IBAction func backToWelcome() {
        drawerController?.hide(animated: true)
        guard let application = UIApplication.shared.delegate as? AppDelegate else { return }
        let welcome = WelcomeViewController()
        application.window?.setRootViewController(welcome, options: .init(direction: .fade, style: .easeIn))
    }
}
