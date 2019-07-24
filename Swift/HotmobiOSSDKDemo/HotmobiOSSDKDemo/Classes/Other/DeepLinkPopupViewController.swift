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
    
    var bannerView2: UIView?
    
    //    var isInitedAdView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "DeepLink Popup"
        self.setupRearViewController()
        
        let adCode = "hotmob_ios_popup_internal"
        HotmobiOSSDK.getHotmobPopup(adCode: adCode, delegate: self)
        
        
        let adCode2: String = "hotmob_ios_banner_inapp"
        let con2 = HotmobiOSSDK.getHotmobBannerController(adCode2, delegate: self, identifier: "banner2")
        self.bannerView2 = con2.returnDisplayView()
        self.bannerView2?.frame = CGRect(x: 0, y: 180, width: 0, height: 0)
        self.view.addSubview(self.bannerView2!)
        
    }
    
    func setupRearViewController(){
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        let aSelector: Selector = #selector(SWRevealViewController.revealToggle(_:))
        let revealButtonItem = UIBarButtonItem(image: UIImage(named: "reveal-icon.png"), style: .plain, target: self.revealViewController(), action: aSelector)
        self.navigationItem.leftBarButtonItem = revealButtonItem
    }
    
}

extension DeepLinkPopupViewController: HotmobControllerDelegate{
    func didLoadBanner(_ banner: UIView){
    }
    
    func didDisplayBanner(_ banner: UIView){
    }
    
    func willDisplayBanner(_ banner: UIView){
    }
    
    func willHideBanner(_ banner: UIView){
    }
    
    func didHideBanner(_ banner: UIView){
    }
    
    func didLoadFailed(){
    }
    
    func openInternalCallback(url: String){
        let internalLinkVC = HMInternalLinkViewController(url: url)
        self.navigationController?.pushViewController(internalLinkVC, animated: true)
    }
    
    func didResizeBanner(_ banner: UIView) {
    }
    
    func videoAdMute() {
        
    }
    
    func videoAdUnmute() {
        
    }
    
}
