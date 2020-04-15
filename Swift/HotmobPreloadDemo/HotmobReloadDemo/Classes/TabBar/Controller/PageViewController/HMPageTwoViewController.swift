//
//  HMPageTwoViewController.swift
//  HotmobReloadDemo
//
//  Created by Paul Cheung on 6/6/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import HotmobiOSSDK

class HMPageTwoViewController: UIViewController {
    
    @IBOutlet weak var adContainerView: UIView!
    var banner: HotmobController?
    
    var isInitedAdView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .green
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if !self.isInitedAdView{
            let adCode: String = "hotmob_ios_banner_inapp"
            banner = HotmobController(type: .Banner, identifier: "Banner C", adCode: adCode, delegate: self)
            self.adContainerView.addSubview(self.banner!.displayView())
            self.isInitedAdView = true

            if Constants.autoReloadMode {
                HotmobReloadManager.sharedInstance.addBanner(controller: banner!, viewController: self)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Constants.autoReloadMode {
            HotmobReloadManager.sharedInstance.setCurrentViewController(to: self)
        }
    }
    
    deinit {
        HotmobReloadManager.sharedInstance.removeViewController(self)
    }
    
}
extension HMPageTwoViewController: HotmobControllerDelegate{
    public func adDidStartLoading(_ ad: HotmobController) {}
    public func adDidLoad(_ ad: HotmobController) {}
    public func noAd(_ ad: HotmobController) {}
    public func adDidShow(_ ad: HotmobController) {
        self.adContainerView.frame.size = ad.displayView().frame.size
    }
    public func adDidHide(_ ad: HotmobController) {
        self.adContainerView.frame.size.height = 0
    }
    public func adDidClick(_ ad: HotmobController) {}
    public func videoAdDidMute(_ ad: HotmobController) {}
    public func videoAdDidUnmute(_ ad: HotmobController) {}
    public func adDidResize(_ ad: HotmobController) {}
    
    func deepLinkDidClick(_ ad: HotmobController, _ url: String) {}
}

