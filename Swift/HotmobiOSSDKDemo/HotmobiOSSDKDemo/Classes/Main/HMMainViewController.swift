//
//  HMMainViewController.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 26/2/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SWRevealViewController

import AppTrackingTransparency
import AdSupport

import CoreLocation
//Custom SDK
import HotmobiOSSDK


class HMMainViewController: HMBaseViewController, UITableViewDelegate, HMUIViewTapDelegate  {
    
//    var bannerView: UIView?
    @IBOutlet weak var lblAdCode: UILabel!
    @IBOutlet weak var adContainerView: UIView!
    @IBOutlet weak var lblBGView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!

    private let HMMainItemTableCellNibName = "HMMainItemTableCell"
    private let ScrollSectionACellID = "ScrollSectionACellID"
    private let ScrollSectionBCellID = "ScrollSectionBCellID"

    private var sectionAUnitSize: CGSize?
    private var sectionBUnitSize: CGSize?
    
    var locationManager: CLLocationManager?
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var adContainerheightConstraint: NSLayoutConstraint!


    var mainViewModel: HMMainViewModel? = HMMainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HTML Banner"
        // Do any additional setup after loading the view.
    
        self.lblAdCode.text = "Welcome Testing Page"
        self.view.backgroundColor = UIColor(red: 48/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1)
        self.lblBGView.backgroundColor = UIColor(red: 34/255.0, green: 34/255.0, blue: 34/255.0, alpha: 1)
        self.lblAdCode.font = UIFont.boldSystemFont(ofSize: 14)
        self.lblAdCode.backgroundColor = .clear
        self.lblAdCode.textColor = .white
        
        self.scrollView.delegate = self
        self.scrollView.isScrollEnabled = true
        self.scrollView.bounces = false
        
        self.adContainerView.backgroundColor = UIColor(red: 48/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1)
        
        self.setupRearViewController()
        self.setupSectionUnits()
        self.setupTableView()
        self.getMainItems()
        
        self.locationManager = CLLocationManager()
        self.startUpdateLocation()
        
        requestIDFA()
    }
    
    func requestIDFA() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                if (status == ATTrackingManager.AuthorizationStatus.authorized) {
                    print("IDFA: true")
                } else {
                    print("IDFA: false")
                }
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.accessibilityIdentifier = "ScrollView"
        scrollView.contentSize.height = 2000
    }
    
    
    func startUpdateLocation() {
        if(CLLocationManager.authorizationStatus() == .notDetermined) {
            self.locationManager?.requestAlwaysAuthorization()
            self.locationManager?.startUpdatingLocation()
        }
        else if(self.checkLocationServiceEnable()) {
            self.locationManager?.startUpdatingLocation()
        }
    }
    
    func checkLocationServiceEnable() -> Bool {
        if(CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways)) {
            return true
        }
        return false
    }
    
    deinit{
        print("deinit HMMainViewController")
        sectionAUnitSize = nil
        sectionBUnitSize = nil
    }
    
    func setupRearViewController(){
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        let aSelector: Selector = #selector(SWRevealViewController.revealToggle(_:))
        let revealButtonItem = UIBarButtonItem(image: UIImage(named: "reveal-icon.png"), style: .plain, target: self.revealViewController(), action: aSelector)
        self.navigationItem.leftBarButtonItem = revealButtonItem
    }
    
    func setupSectionUnits(){
        self.sectionAUnitSize = CGSize(width: 80, height: 30)
        self.sectionBUnitSize = CGSize(width: 100, height: 30)

    }
    
    func setupTableView(){
        self.mainTableView.backgroundColor =  UIColor(red: 48/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1)
        
        self.mainTableView.register(UINib(nibName: self.HMMainItemTableCellNibName, bundle: HMResourcesLoader.frameworkBundle()), forCellReuseIdentifier: self.ScrollSectionACellID)
        self.mainTableView.register(UINib(nibName: self.HMMainItemTableCellNibName, bundle: HMResourcesLoader.frameworkBundle()), forCellReuseIdentifier: self.ScrollSectionBCellID)

        self.mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCellID")

        self.mainTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, HMBaseViewModel>>(configureCell: { [unowned self] (ds, tv, indexPath, model) in
            
            let row: Int = indexPath.row
            let displayTypeIndexPath = NSIndexPath(row: row, section: 0)
            
            var displayType: String = ""
            if let vm = model as? HMMainItemViewModel {
                displayType = vm.displayType.value!
            }
            
            switch displayType {
            case "1":
                let cellModel: HMMainItemViewModel = model as! HMMainItemViewModel
                let cell = tv.dequeueReusableCell(withIdentifier: self.ScrollSectionACellID)! as! HMMainItemTableCell
                cell.delegate = self
                cell.viewModel = cellModel
                
                cell.horizontalScrollView.collectionView?.indexPath = displayTypeIndexPath
                cell.horizontalScrollView.collectionView?.dataSource = self
                cell.horizontalScrollView.collectionView?.delegate = self
                cell.horizontalScrollView.collectionView?.reloadData()
                
                return cell
            case "3":
                let cellModel: HMMainItemViewModel = model as! HMMainItemViewModel
                let cell = tv.dequeueReusableCell(withIdentifier: self.ScrollSectionBCellID)! as! HMMainItemTableCell
                cell.delegate = self
                cell.viewModel = cellModel
                
                cell.horizontalScrollView.collectionView?.indexPath = displayTypeIndexPath
                cell.horizontalScrollView.collectionView?.dataSource = self
                cell.horizontalScrollView.collectionView?.delegate = self
                cell.horizontalScrollView.collectionView?.reloadData()
                
                return cell
            default:
                let cell = tv.dequeueReusableCell(withIdentifier: "DefaultCellID")
                return cell!
            }
        })
        
        self.mainViewModel?.itemList?.asObservable()
            .bind(to: self.mainTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func getMainItems(){
        self.mainViewModel?.getLocalJSONMain()
            .subscribe(onNext: { (_) in
            }, onError: { (error) in
            }).disposed(by: self.disposeBag)
    }
    
    func viewDidTap(gesture: HMUITapGestureRecognizer) {
        let viewModel = gesture.model

        if let viewModel = viewModel as? HMMainItemUnitTypeAViewModel {
            print("onClcik \(viewModel.title.value!)")
            switch viewModel.title.value! {
            case "Dynamic":
                self.adContainerView.frame.size.height = 0
                break
            case "Standard":
                self.adContainerView.frame.size.height = 50
                break
            case "Maxi":
                self.adContainerView.frame.size.height = 100
                break
            case "LREC":
                self.adContainerView.frame.size.height = 200
                break
            default:
                break
            }
            
        }else if let viewModel = viewModel as? HMMainItemUnitTypeBViewModel {
//            print("onClcik \(viewModel.title.value!)")
            self.addAdView(viewModel.adCode.value!)
        }
    }
    
    func addAdView(_ adCode: String){
        if let b = self.banner {
            b.hide()
            b.adCode = adCode
            b.loadAd()
        } else {
            let banner = HotmobController(type: .Banner, identifier: "Banner", adCode: adCode, delegate: self)
            banner.animated = true
            banner.containsInView = scrollView
            adContainerView.addSubview(banner.displayView())
            banner.loadAd()
            self.banner = banner
        }
        self.lblAdCode.text = adCode
    }
}


extension HMMainViewController: UICollectionViewDelegate{

}


extension HMMainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let indexCollectionView = collectionView as! HMIndexedCollectionView
        let mainItem = self.mainViewModel?.itemList?.value[0].items[(indexCollectionView.indexPath?.row)!] as! HMMainItemViewModel
        return (mainItem.itemUnitList.value?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let indexCollectionView = collectionView as! HMIndexedCollectionView
        let mainItem = self.mainViewModel?.itemList?.value[0].items[(indexCollectionView.indexPath?.row)!] as! HMMainItemViewModel
        let unitItem = mainItem.itemUnitList.value?[indexPath.row]
        
        let sectionDisplayType = mainItem.displayType.value
        
        if(sectionDisplayType == "1") {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HMIndexedCollectionView.MainUnitTypeACollectionViewCellID, for: indexPath) as! HMMainUnitTypeACollectionViewCell
            cell.mainUnitView?.delegate = self
            cell.viewModel = unitItem as! HMMainItemUnitTypeAViewModel?
            return cell
        }else if(sectionDisplayType == "3") {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HMIndexedCollectionView.MainUnitTypeBCollectionViewCellID, for: indexPath) as! HMMainUnitTypeBCollectionViewCell
            cell.mainUnitView?.delegate = self
            cell.viewModel = unitItem as! HMMainItemUnitTypeBViewModel?
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCollectionViewCellID", for: indexPath)
            return cell
        }
    }
}

extension HMMainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let indexCollectionView = collectionView as! HMIndexedCollectionView
        let mainItem = self.mainViewModel?.itemList?.value[0].items[(indexCollectionView.indexPath?.row)!] as! HMMainItemViewModel
        let sectionDisplayType = mainItem.displayType.value
        
        let size: CGSize
        
        if(sectionDisplayType == "1") {
            size = self.sectionAUnitSize!
        }else if(sectionDisplayType == "3") {
            size = self.sectionBUnitSize!
        }else {
            size = CGSize.zero
        }
        return size
    }
    
}

extension HMMainViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}

extension HMMainViewController: HotmobControllerDelegate{
    func adDidStartLoading(_ ad: HotmobController) {}
    func adDidLoad(_ ad: HotmobController) {}
    func noAd(_ ad: HotmobController) {
        self.lblAdCode.text = "No Ad Return"
    }
    func adDidShow(_ ad: HotmobController) {
        let banner = ad.displayView()
        self.adContainerheightConstraint.constant = banner.frame.size.height
        self.scrollView.contentSize.height = banner.frame.size.height + self.lblBGView.frame.size.height
    }
    func adDidHide(_ ad: HotmobController) {
        print("\(self.classForCoder) --- didHideBanner")
        self.adContainerheightConstraint.constant = 0
        self.scrollView.contentSize.height = self.lblBGView.frame.size.height
    }
    func adDidClick(_ ad: HotmobController) {}
    func videoAdDidMute(_ ad: HotmobController) {
        showToast(message: "Ad Mute", font: nil)
        print("<<AUDIO>> ad mute")
    }
    func videoAdDidUnmute(_ ad: HotmobController) {
        showToast(message: "Ad Unmute", font: nil)
        print("<<AUDIO>> ad unmute")
    }
    func adDidResize(_ ad: HotmobController) {
        showToast(message: "Resize \(ad.displayView().frame.height)", font: nil)
        let banner = ad.displayView()
        self.adContainerheightConstraint.constant = banner.frame.size.height
        self.scrollView.contentSize.height = banner.frame.size.height + self.lblBGView.frame.size.height
    }
    
    func deepLinkDidClick(_ ad: HotmobController, _ url: String) {
        let internalLinkVC = HMInternalLinkViewController(url: url)
        self.navigationController?.pushViewController(internalLinkVC, animated: true)
    }
}

extension HMMainViewController {

    func showToast(message : String, font: UIFont?) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font ?? UIFont(name: "IranSansMobile", size: 19)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

