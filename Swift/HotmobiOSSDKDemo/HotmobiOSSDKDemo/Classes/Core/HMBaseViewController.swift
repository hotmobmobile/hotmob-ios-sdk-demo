//
//  HMBaseViewController.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HotmobiOSSDK

class HMBaseViewController: UIViewController {

    let disposeBag = DisposeBag()
    
//    var bannerView: UIView?
    var banner: HotmobController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupRightBarButtonItem()

    }
    
    deinit{
//        print("deinit HMBaseViewController")
    }
    
    func setupRightBarButtonItem() {
        
        let customButton: UIButton = UIButton(type: .custom)
        customButton.frame = CGRect(x: 3, y: 9, width: 72, height: 22)
        if HotmobiOSSDK.returnCurrentLocale() == "HK"{
            customButton.setTitle("HK", for: .normal)
        }else{
            customButton.setTitle("JP", for: .normal)
        }
        customButton.addTarget(self, action: #selector(changeLocale), for: .touchUpInside)
        customButton.setTitleColor(UIColor.black, for: .normal)
        customButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        customButton.titleLabel?.textAlignment = .right
        
        let rightButton: UIBarButtonItem = UIBarButtonItem(customView: customButton)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func changeLocale(){
        if HotmobiOSSDK.returnCurrentLocale() == "HK"{
            HotmobiOSSDK.setCurrentLocale(loc: "JP")
            let item = self.navigationItem.rightBarButtonItem!
            let button = item.customView as! UIButton
            button.setTitle("JP", for: .normal)
        }else{
            HotmobiOSSDK.setCurrentLocale(loc: "HK")
            let item = self.navigationItem.rightBarButtonItem!
            let button = item.customView as! UIButton
            button.setTitle("HK", for: .normal)
        }
    }


}
