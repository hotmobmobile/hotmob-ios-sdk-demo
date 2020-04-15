//
//  HMMainViewController.swift
//  HotmobReloadDemo
//
//  Created by Paul Cheung on 8/4/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import SWRevealViewController
import HotmobiOSSDK

class HMMainViewController: HMBaseViewController {

    @IBOutlet weak var btnGoDetails: UIButton!
    @IBOutlet weak var btnSkipInterstitial: UIButton!
    @IBOutlet weak var adContainerView: UIView!
    var banner: HotmobController?
    
    @IBOutlet weak var adContainerView2: UIView!
    var banner2: HotmobController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let popup = HotmobController(type: .Interstitial, identifier: "ResumePopup", adCode: "hotmob_ios_popup_external")
        HotmobReloadManager.sharedInstance.setResumeInterstitial(controller: popup, loadNow: false)

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false

        self.setupRearViewController()
        self.btnGoDetails.addTarget(self, action: #selector(goDetailsPage), for: .touchDown)
        self.btnSkipInterstitial.addTarget(self, action: #selector(skipInterstitialOnce), for: .touchDown)
        
        self.addAdView()
        
        self.title = "HotmobSDK Reload App"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Constants.autoReloadMode {
            HotmobReloadManager.sharedInstance.setCurrentViewController(to: self)
        }
    }
    
    func addAdView(){
        let adCode: String = "hotmob_ios_banner_external"
        banner = HotmobController(type: .Banner, identifier: "banner1", adCode: adCode, delegate: self)
        self.adContainerView.addSubview(self.banner!.displayView())
        
        let adCode2: String = "hotmob_ios_banner_inapp"
        banner2 = HotmobController(type: .Banner, identifier: "banner2", adCode: adCode2, delegate: self)
        self.adContainerView2.addSubview(self.banner2!.displayView())
        
        if Constants.autoReloadMode {
            HotmobReloadManager.sharedInstance.addBanner(controller: banner!, viewController: self)
            HotmobReloadManager.sharedInstance.addBanner(controller: banner2!, viewController: self)
        }
    }
    
    func setupRearViewController(){
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        let aSelector: Selector = #selector(SWRevealViewController.revealToggle(_:))
        let revealButtonItem = UIBarButtonItem(image: UIImage(named: "reveal-icon.png"), style: .plain, target: self.revealViewController(), action: aSelector)
        self.navigationItem.leftBarButtonItem = revealButtonItem
    }
    
    @objc func goDetailsPage(){
        HotmobReloadManager.sharedInstance.showPreloadInterstitial(key: "Interpage") { event, deeplink in
            switch (event) {
            case .Show:
                // do nothing to wait for ad show
                break
            case .Showing:
                // do nothing as ad is already showing
                break
            case .Fail, .NoAd, .Hide:
                // no ad or ad is closed, can change page now
                let detailsVC = HMDetialsViewController()
                self.navigationController?.pushViewController(detailsVC, animated: true)
                break
            case .DeepLink:
                // Do deep link change page here
                let detailsVC = HMDetialsViewController()
                detailsVC.url = deeplink
                self.navigationController?.pushViewController(detailsVC, animated: true)
                break
            }
        }
    }
    
    @objc func skipInterstitialOnce(){
        HotmobReloadManager.sharedInstance.disableResumeInterstitialOnce()
    }
    
    deinit {
        HotmobReloadManager.sharedInstance.removeViewController(self)
    }
}

extension HMMainViewController: HotmobControllerDelegate{
    func adDidStartLoading(_ ad: HotmobController) {}
    func adDidLoad(_ ad: HotmobController) {}
    func noAd(_ ad: HotmobController) {}
    func adDidShow(_ ad: HotmobController) {
        if ad.identifier == "banner1"{
            self.adContainerView.frame.size = ad.displayView().frame.size
        }else if ad.identifier == "banner2"{
            self.adContainerView2.frame.size = ad.displayView().frame.size
        }
    }
    func adDidHide(_ ad: HotmobController) {
        if ad.identifier == "banner1"{
            self.adContainerView.frame.size = ad.displayView().frame.size
        }else if ad.identifier == "banner2"{
            self.adContainerView2.frame.size = ad.displayView().frame.size
        }
    }
    func adDidClick(_ ad: HotmobController) {}
    func videoAdDidMute(_ ad: HotmobController) {}
    func videoAdDidUnmute(_ ad: HotmobController) {}
    func adDidResize(_ ad: HotmobController) {}
    
    func deepLinkDidClick(_ ad: HotmobController, _ url: String) {}
}

