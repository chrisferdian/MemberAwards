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
        print(FeedViewController.className)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.justifyleft"), style: .done, target: self, action: #selector(showLeft))
    }
    
    @objc func showLeft() {
        drawerController?.show(.left, animated: true)
    }
}
