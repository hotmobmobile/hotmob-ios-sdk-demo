//
//  HMMainUnitTypeACollectionViewCell.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit

class HMMainUnitTypeACollectionViewCell: HMMainUnitBaseCollectionViewCell {
    var mainUnitView: HMMainUnitTypeAView?
    var viewModel:  HMMainItemUnitTypeAViewModel? = nil {
        didSet {
            self.mainUnitView?.viewModel = viewModel
            self.mainUnitView?.lblTitle.text = viewModel?.title.value!
        }
    }
    
    deinit {
//        print("deinit HMMainUnitTypeACollectionViewCell")
        self.mainUnitView = nil
        self.viewModel = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.mainUnitView = HMResourcesLoader.frameworkBundle().loadNibNamed("HMMainUnitView", owner: self, options: nil)?[0] as! HMMainUnitTypeAView?
        self.mainUnitView?.frame.size = frame.size
        self.addSubview(self.mainUnitView!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
