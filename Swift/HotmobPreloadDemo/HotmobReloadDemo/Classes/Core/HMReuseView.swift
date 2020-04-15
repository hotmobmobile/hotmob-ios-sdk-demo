//
//  HMReuseView.swift
//  HotmobReloadDemo
//
//  Created by Paul Cheung on 8/4/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit

class HMReuseView: UIView {
    
    var mainContentView: UIView?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.mainContentView?.frame.size = self.frame.size
    }
}
