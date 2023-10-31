//
//  HMMainUnitTypeBCollectionViewCell.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit

class HMMainUnitTypeBCollectionViewCell: HMMainUnitBaseCollectionViewCell {
    var mainUnitView: HMMainUnitTypeBView?
    var viewModel:  HMMainItemUnitTypeBViewModel? = nil {
        didSet {
            self.mainUnitView?.viewModel = viewModel
            self.mainUnitView?.lblTitle.text = viewModel?.title.value!
            self.mainUnitView?.accessibilityIdentifier = viewModel?.title.value!
        }
    }
    
    deinit {
//        print("deinit HMMainUnitTypeBCollectionViewCell")
        self.mainUnitView = nil
        self.viewModel = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.mainUnitView = HMResourcesLoader.frameworkBundle().loadNibNamed("HMMainUnitView", owner: self, options: nil)?[1] as! HMMainUnitTypeBView?
        self.mainUnitView?.frame.size = frame.size
        self.addSubview(self.mainUnitView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
