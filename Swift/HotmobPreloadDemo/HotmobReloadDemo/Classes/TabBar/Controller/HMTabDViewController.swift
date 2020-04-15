//
//  HMTabDViewController.swift
//  HotmobReloadDemo
//
//  Created by Paul Cheung on 8/4/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import HotmobiOSSDK

class HMTabDViewController: UIViewController {

    @IBOutlet weak var adContainerView: UIView!
    var banner: HotmobController?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .purple
                
        self.adContainerView.backgroundColor = .black
        self.addAdView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Constants.autoReloadMode {
            HotmobReloadManager.sharedInstance.setCurrentViewController(to: self)
        }
    }

    deinit {
        print("deinit HMTabDViewController")
        HotmobReloadManager.sharedInstance.removeViewController(self)
    }
    
    func addAdView(){
        let adCode: String = "hotmob_ios_banner_inapp"
//        let adCode: String = "hotmob_ios_banner_appstore"
        
        banner = HotmobController(type: .Banner, identifier: "Banner D", adCode: adCode, delegate: self)
        self.adContainerView.addSubview(self.banner!.displayView())
        if Constants.autoReloadMode {
            HotmobReloadManager.sharedInstance.addBanner(controller: banner!, viewController: self)
        }
    }
}

extension HMTabDViewController: HotmobControllerDelegate{
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
    
    public func deepLinkDidClick(_ ad: HotmobController, _ url: String) {}
}
