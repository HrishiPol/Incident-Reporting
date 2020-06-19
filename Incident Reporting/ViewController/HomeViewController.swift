//
//  HomeViewController.swift
//  Incident Reporting
//
//  Created by Hrishikesh Pol on 18/6/20.
//  Copyright © 2020 Hrishikesh Pol. All rights reserved.
//

import UIKit

/// Landing view controller.
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = Constant.kHomeTitle.rawValue
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
}
