//
//  HMMainUnitTypeAView.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit

class HMMainUnitTypeAView: UIView {

    @IBOutlet weak var lblTitle: UILabel!
    
    var viewTapGesture: HMUITapGestureRecognizer?
    
    weak var delegate: HMUIViewTapDelegate? = nil
    
    var viewModel: HMMainItemUnitTypeAViewModel? = nil {
        didSet {
            self.viewTapGesture?.model = viewModel
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor =  UIColor(red: 90/255.0, green: 90/255.0, blue: 90/255.0, alpha: 1)
        self.lblTitle.textColor = .white
        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 14)

        self.viewTapGesture = HMUITapGestureRecognizer(target: self, action: #selector(self.tapGestureAction(gesture:)))
        self.viewTapGesture?.key = "view"
        self.addGestureRecognizer(self.viewTapGesture!)
        
        self.lblTitle.textAlignment = .center
        
        self.lblTitle.layer.borderWidth = 0.5
        self.lblTitle.layer.cornerRadius = self.lblTitle.frame.size.height / 2
        self.lblTitle.layer.borderColor = UIColor.white.cgColor
        
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = self.lblTitle.frame.size.height / 2
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    deinit {
        print("deinit HMMainUnitTypeAView")
        self.viewTapGesture = nil
    }


    @objc func tapGestureAction(gesture: HMUITapGestureRecognizer) {
        self.delegate?.viewDidTap(gesture: gesture)
    }

}
