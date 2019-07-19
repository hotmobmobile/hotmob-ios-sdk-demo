//
//  HMRearItemReuseView.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 7/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit

class HMRearItemReuseView: HMReuseView {

    @IBOutlet var lblSectionTitle: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.customInit()
    }
    
    func customInit() {
        self.mainContentView = (HMResourcesLoader.frameworkBundle().loadNibNamed("HMRearItemReuseView", owner: self, options: nil)?.first as! UIView)
        self.addSubview(self.mainContentView!)
        self.lblSectionTitle.font = UIFont.systemFont(ofSize: 14)
        
    }

}
