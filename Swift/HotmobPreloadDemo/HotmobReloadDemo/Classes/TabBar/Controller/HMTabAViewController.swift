//
//  HMTabAViewController.swift
//  HotmobReloadDemo
//
//  Created by Paul Cheung on 8/4/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import HotmobiOSSDK

class HMTabAViewController: UIViewController {

    @IBOutlet weak var adContainerView: UIView!
    var banner: HotmobController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .blue
        
        self.adContainerView.backgroundColor = .black
        self.addAdView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Constants.autoReloadMode {
            HotmobReloadManager.sharedInstance.setCurrentViewController(to: self)
        }
    }
    
    func addAdView(){
        let adCode: String = "hotmob_ios_videobanner_email"

        banner = HotmobController(type: .Banner, identifier: "Banner A", adCode: adCode, delegate: self)
        banner?.selfReload = false
        self.adContainerView.addSubview(self.banner!.displayView())
        banner?.loadAd()
    }
    

    deinit {
        print("deinit HMTabAViewController")
    }
}


extension HMTabAViewController: HotmobControllerDelegate{
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
