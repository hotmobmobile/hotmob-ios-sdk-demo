//
//  HMTabBViewController.swift
//  HotmobReloadDemo
//
//  Created by Paul Cheung on 8/4/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import HotmobiOSSDK

class HMTabBViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .yellow
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Constants.autoReloadMode {
            HotmobReloadManager.sharedInstance.setCurrentViewController(to: self)
        }
    }
    
    deinit {
        print("deinit HMTabBViewController")
    }
}
