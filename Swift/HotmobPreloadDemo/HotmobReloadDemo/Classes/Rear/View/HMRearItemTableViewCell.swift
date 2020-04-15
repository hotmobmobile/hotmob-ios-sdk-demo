//
//  HMRearItemTableViewCell.swift
//  HotmobReloadDemo
//
//  Created by Paul Cheung on 8/4/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//


import UIKit

class HMRearItemTableViewCell: UITableViewCell {

    @IBOutlet var lblSectionTitle: UILabel!
    
    var viewModel: HMRearCatItemViewModel? = nil{
        didSet{
            lblSectionTitle.text = viewModel!.title.value
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
