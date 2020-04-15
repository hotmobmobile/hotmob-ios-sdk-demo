//
//  HMTabBarViewController.swift
//  HotmobReloadDemo
//
//  Created by Paul Cheung on 8/4/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import SWRevealViewController
import HotmobiOSSDK

class HMTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setupRearViewController()
        self.setupTabBar()
    }
    
    func setupRearViewController(){
//        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        let aSelector: Selector = #selector(SWRevealViewController.revealToggle(_:))
        let revealButtonItem = UIBarButtonItem(image: UIImage(named: "reveal-icon.png"), style: .plain, target: self.revealViewController(), action: aSelector)
        self.navigationItem.leftBarButtonItem = revealButtonItem
    }
    
    func setupTabBar() {
        self.tabBar.barTintColor = UIColor.white
        self.view.frame = UIScreen.main.bounds
        
        var tmpTabBarList: [UINavigationController] = []
        
        let aVC = HMTabAViewController()
        let tabA = UINavigationController(rootViewController: aVC)
        tabA.tabBarItem = UITabBarItem(title: "Tab A", image: nil, selectedImage: nil)
        tmpTabBarList.append(tabA)
        
        let bVC = HMTabBViewController()
        let tabB = UINavigationController(rootViewController: bVC)
        tabB.tabBarItem = UITabBarItem(title: "Tab B", image: nil, selectedImage: nil)
        tmpTabBarList.append(tabB)
        
        let cVC = HMRootPageViewController()
        let tabC = UINavigationController(rootViewController: cVC)
        tabC.tabBarItem = UITabBarItem(title: "Tab C", image: nil, selectedImage: nil)
        tmpTabBarList.append(tabC)
        
        let dVC = HMTabDViewController()
        let tabD = UINavigationController(rootViewController: dVC)
        tabD.tabBarItem = UITabBarItem(title: "Tab D", image: nil, selectedImage: nil)
        tmpTabBarList.append(tabD)
        
        self.tabBar.isTranslucent = false
        self.delegate = self
        self.viewControllers = tmpTabBarList
    }
    
    deinit {
        print("deinit HMTabBarViewController")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITabBarControllerDelegate
extension HMTabBarViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){

    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
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
                tabBarController.selectedViewController = viewController
                break
            case .DeepLink:
                // Do deep link change page here
                break
            }
        }
        return false
    }
}
