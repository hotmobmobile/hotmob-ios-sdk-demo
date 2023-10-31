//
//  DeepLinkPopupViewController.swift
//  HotmobiOSSDKDemo

//
//  Created by Paul Cheung on 11/7/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import SWRevealViewController
import HotmobiOSSDK

class DeepLinkPopupViewController: HMBaseViewController {
    
    var popup: HotmobController?
    
    //    var isInitedAdView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "DeepLink Popup"
        self.setupRearViewController()
        
        let adCode = "hotmob_ios_popup_internal"
        popup = HotmobController(type: .Interstitial, identifier: "Popup", adCode: adCode, delegate: self)
        popup?.loadAd()
        
        let adCode2: String = "hotmob_ios_banner_inapp"
//        let con2 = HotmobiOSSDK.getHotmobBannerController(adCode2, delegate: self, identifier: "banner2")
//        self.bannerView2 = con2.displayView()
//        self.bannerView2?.frame = CGRect(x: 0, y: 180, width: 0, height: 0)
//        self.view.addSubview(self.bannerView2!)
        
        self.banner = HotmobController(type: .Banner, identifier: "Banner", adCode: adCode2, delegate: self)
        let bannerView = self.banner!.displayView()
        bannerView.frame = CGRect(x: 0, y: 180, width: UIScreen.main.bounds.width, height: 1)
        self.view.addSubview(bannerView)
        
    }
    
    func setupRearViewController(){
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        let aSelector: Selector = #selector(SWRevealViewController.revealToggle(_:))
        let revealButtonItem = UIBarButtonItem(image: UIImage(named: "reveal-icon.png"), style: .plain, target: self.revealViewController(), action: aSelector)
        self.navigationItem.leftBarButtonItem = revealButtonItem
    }
    
}

extension DeepLinkPopupViewController: HotmobControllerDelegate{
    func adDidStartLoading(_ ad: HotmobController) {}
    func adDidLoad(_ ad: HotmobController) {}
    func noAd(_ ad: HotmobController) {}
    func adDidShow(_ ad: HotmobController) {}
    func adDidHide(_ ad: HotmobController) {}
    func adDidClick(_ ad: HotmobController) {}
    func videoAdDidMute(_ ad: HotmobController) {}
    func videoAdDidUnmute(_ ad: HotmobController) {}
    func adDidResize(_ ad: HotmobController) {}
    
    func deepLinkDidClick(_ ad: HotmobController, _ url: String) {
        let internalLinkVC = HMInternalLinkViewController(url: url)
        self.navigationController?.pushViewController(internalLinkVC, animated: true)
    }
}
