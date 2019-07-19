//
//  HMMainUnitTypeATableViewCell.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit

class HMMainUnitTypeATableViewCell: HMMainUnitBaseTableViewCell {
    
    var mainUnitView: HMMainUnitTypeAView?
    var viewModel: HMMainItemUnitTypeAViewModel? = nil {
        didSet {
            self.mainUnitView?.viewTapGesture?.model = viewModel
            self.mainUnitView?.lblTitle.text = viewModel?.title.value!
        }

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.mainUnitView = HMResourcesLoader.frameworkBundle().loadNibNamed("HMMainUnitView", owner: self, options: nil)?[0] as! HMMainUnitTypeAView?
        self.addSubview(self.mainUnitView!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit HMMainUnitTypeATableViewCell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.mainUnitView?.frame = CGRect(x: self.margin, y: self.margin, width: self.frame.size.width - self.margin * 2, height: self.frame.size.height - self.margin * 2)
    }

}
