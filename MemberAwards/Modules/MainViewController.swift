//
//  MainViewController.swift
//  MemberAwards
//
//  Created by Chris Ferdian on 10/02/20.
//  Copyright © 2020 Chrizers. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let feedView = FeedViewController(nibName: "FeedViewController", bundle: nil)
        let rootController = RootViewController(mainViewController: feedView, topNavigationLeftImage: UIImage(systemName: "text.justifyleft"))
        let menuVC = MenuViewController()
        menuVC.view.backgroundColor = .green
        
        let drawerVC = DrawerController(rootViewController: rootController, menuController: menuVC)
        self.addChild(drawerVC)
        view.addSubview(drawerVC.view)
        drawerVC.didMove(toParent: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
