//
//  HMInternalLinkViewController.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/4/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit

class HMInternalLinkViewController: HMBaseViewController {

    var url: String?
    
    @IBOutlet weak var lblURL: UILabel!
    
    init(url: String) {
        super.init(nibName: "HMInternalLinkViewController", bundle: HMResourcesLoader.frameworkBundle())
        self.url = url
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.lblURL.text = "InternalLink URL: \n \(self.url!)"
        self.lblURL.textColor = .white
    }

}
