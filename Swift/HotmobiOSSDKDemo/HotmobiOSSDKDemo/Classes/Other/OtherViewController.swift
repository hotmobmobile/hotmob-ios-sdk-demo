//
//  OtherViewController.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 10/7/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import HotmobiOSSDK
import RxSwift
import RxCocoa
import SWRevealViewController

class OtherViewController: HMBaseViewController {

    @IBOutlet var btnVAST: UIButton!
    @IBOutlet var btnLocation: UIButton!
    @IBOutlet var lblValue: UILabel!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "VAST & Location"
        
        self.setupRearViewController()

        self.setVASTAction()
        self.setLocationAction()
        
//        self.updateLayout()
    }
    
    func setupRearViewController(){
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        let aSelector: Selector = #selector(SWRevealViewController.revealToggle(_:))
        let revealButtonItem = UIBarButtonItem(image: UIImage(named: "reveal-icon.png"), style: .plain, target: self.revealViewController(), action: aSelector)
        self.navigationItem.leftBarButtonItem = revealButtonItem
    }
    
//    func updateLayout(){
//        self.heightConstraint.constant = 100
//        self.view.layoutSubviews()
//        self.view.updateConstraints()
//    }
    
    func setVASTAction(){
        self.btnVAST.rx.tap
            .subscribe(onNext: {
                let dict = NSDictionary(object: ["action","adventure","fantasy"], forKey: "category" as NSCopying)
                self.lblValue.text = HotmobiOSSDK.getVASTURL(adProfile: "a", withDuration: 120, withExtra: dict)
            })
            .disposed(by: disposeBag)
    }
    
    func setLocationAction(){
        self.btnLocation.rx.tap
            .subscribe(onNext: {
                print("button Location")
                 self.lblValue.text = HotmobiOSSDK.getCurrentLocation()
            })
            .disposed(by: disposeBag)
    }
    
    
    
    
}
