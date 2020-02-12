//
//  FeedViewController.swift
//  MemberAwards
//
//  Created by Chris Ferdian on 10/02/20.
//  Copyright © 2020 Chrizers. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Awards"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.justifyleft"), style: .done, target: self, action: #selector(showDrawerMenu))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease"), style: .done, target: self, action: #selector(showFilterPage))
    }
    
    @objc func showDrawerMenu() {
        drawerController?.show(.left, animated: true)
    }
    @objc func showFilterPage() {
        self.navigationController?.present(FilterViewController(), animated: true, completion: nil)
    }
}
