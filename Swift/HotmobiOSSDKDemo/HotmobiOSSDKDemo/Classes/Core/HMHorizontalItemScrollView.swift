//
//  HMHorizontalItemScrollView.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit

class HMHorizontalItemScrollView: UIView {
    var collectionView: HMIndexedCollectionView?
    var margins: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    var itemSize: CGSize = CGSize.zero
    
    init(frame: CGRect, itemSize: CGSize) {
        super.init(frame: frame)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = margins
        layout.itemSize = itemSize
        layout.scrollDirection = .horizontal
        self.collectionView = HMIndexedCollectionView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), collectionViewLayout: layout)
        
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: HMIndexedCollectionView.MainUnitTypeACollectionViewCellID)
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: HMIndexedCollectionView.MainUnitTypeBCollectionViewCellID)

        self.collectionView?.backgroundColor = UIColor.clear
        self.collectionView?.showsHorizontalScrollIndicator = false;
        self.addSubview(self.collectionView!)
        
        //        self.collectionView?.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.itemSize = CGSize(width: 80, height: 120)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = margins
        layout.itemSize = self.itemSize
        layout.scrollDirection = .horizontal
        self.collectionView = HMIndexedCollectionView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), collectionViewLayout: layout)
        
        //Testing setup
        self.collectionView?.register(HMMainUnitTypeACollectionViewCell.self, forCellWithReuseIdentifier: HMIndexedCollectionView.MainUnitTypeACollectionViewCellID)
        self.collectionView?.register(HMMainUnitTypeBCollectionViewCell.self, forCellWithReuseIdentifier: HMIndexedCollectionView.MainUnitTypeBCollectionViewCellID)

        
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCollectionViewCellID")
        
        self.collectionView?.backgroundColor = UIColor.clear
        self.collectionView?.showsHorizontalScrollIndicator = false;
        self.addSubview(self.collectionView!)
        
        self.backgroundColor = UIColor.clear
        //        print("collectionSize: \(collectionView?.frame)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.collectionView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    // MARK: - Custom methods
    func register(nib: UINib, cellIdentifier: String) {
        self.collectionView?.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func register(cellClass: AnyClass?, cellIdentifier: String) {
        self.collectionView?.register(cellClass, forCellWithReuseIdentifier: cellIdentifier)
    }
}

class HMIndexedCollectionView: UICollectionView {
    var indexPath: NSIndexPath?
    static var MainUnitTypeACollectionViewCellID: String = "HMMainUnitTypeACollectionViewCell"
    static var MainUnitTypeBCollectionViewCellID: String = "HMMainUnitTypeBCollectionViewCell"

}
