//
//  HMMainItemTableCell.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit

class HMMainItemTableCell: UITableViewCell {
    
    @IBOutlet weak var horizontalScrollView: HMHorizontalItemScrollView!

    var viewTapGesture: HMUITapGestureRecognizer?
    weak var delegate: HMUIViewTapDelegate? = nil

    var viewModel: HMMainItemViewModel? {
        didSet {
            self.viewTapGesture?.model = viewModel
        }
    }

    deinit {
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
    }

//    func tapGestureAction(gesture: HMUITapGestureRecognizer) {
//        self.delegate?.viewDidTap(gesture: gesture)
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
