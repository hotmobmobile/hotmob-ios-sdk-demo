//
//  HMDetialsViewController.swift
//  HotmobReloadDemo
//
//  Created by Paul Cheung on 9/4/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import HotmobiOSSDK

class HMDetialsViewController: UIViewController {
    
    @IBOutlet weak var text: UILabel!
    
    public var url = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !url.isEmpty {
            text.text = url
        }
        if Constants.autoReloadMode {
            HotmobReloadManager.sharedInstance.setCurrentViewController(to: self)
        }
    }

}
