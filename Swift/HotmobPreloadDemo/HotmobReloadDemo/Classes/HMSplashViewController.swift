//
//  HMSplashViewController.swift
//  HotmobPreloadDemo
//
//  Created by Ken Wong on 2/4/2020.
//  Copyright © 2020 Paul Cheung. All rights reserved.
//

import UIKit
import HotmobiOSSDK
import SWRevealViewController

class HMSplashViewController: UIViewController, SWRevealViewControllerDelegate {
    
    // Create an Interstitial without auto showing
    private var popup: HotmobController = HotmobController(type: .Interstitial, identifier: "LaunchPopup", adCode: "hotmob_android_google_ad", autoShow: false)
    
    private var selfLoadingComplete = false
    private var interstitialDeepLink = ""
    private var deepLinkUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        popup.delegate = self
        popup.loadAd()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // simulate app resources loading delay
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3000), execute: {
            NSLog("PreloadDemo - asyncAfter()")
            self.selfLoadingComplete = true
            self.shouldShowInterstitial()
        })
    }
    
    // A function checking the Interstitial status for next action
    private func shouldShowInterstitial() {
        NSLog("PreloadDemo - shouldShowInterstitial()")
        if (selfLoadingComplete) {
            if (popup.status == .Loaded) {
                popup.show()
            } else if (popup.status == .Fail) {
                // No ad is showing, go to main page
                goToMainPage()
            }
        }
    }
    
    private func goToMainPage() {
        let mainVC = HMMainViewController()
        let mainNav = UINavigationController.init(rootViewController: mainVC)

        let rearVC = HMRearViewController()
        let rearNav = UINavigationController.init(rootViewController: rearVC)

        let revealController: SWRevealViewController = SWRevealViewController(rearViewController: rearNav, frontViewController: mainNav)
        revealController.delegate = self
        if #available(iOS 13.0, *) {
            revealController.modalPresentationStyle = .fullScreen
        }
        self.present(revealController, animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HMSplashViewController: HotmobControllerDelegate{
    func adDidStartLoading(_ ad: HotmobController) {}
    func adDidLoad(_ ad: HotmobController) {
        NSLog("PreloadDemo - adDidLoad()")
        shouldShowInterstitial()
    }
    func noAd(_ ad: HotmobController) {
        NSLog("PreloadDemo - noAd()")
        shouldShowInterstitial()
    }
    func adDidShow(_ ad: HotmobController) {}
    func adDidHide(_ ad: HotmobController) {
        NSLog("PreloadDemo - adDidHide()")
        if deepLinkUrl.isEmpty {
            goToMainPage()
        } else {
            // do deep link redirect
            NSLog("PreloadDemo - deep link is \(deepLinkUrl)")
            goToMainPage()
        }
    }
    func adDidClick(_ ad: HotmobController) {}
    func videoAdDidMute(_ ad: HotmobController) {}
    func videoAdDidUnmute(_ ad: HotmobController) {}
    func adDidResize(_ ad: HotmobController) {}
    
    func deepLinkDidClick(_ ad: HotmobController, _ url: String) {
        NSLog("PreloadDemo - deepLinkDidClick()") // call before adDidHide()
        deepLinkUrl = url
    }
}
