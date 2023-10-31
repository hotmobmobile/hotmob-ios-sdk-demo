//
//  HMMainVideoViewController.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 7/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SWRevealViewController
import HotmobiOSSDK

class HMMainVideoViewController: HMBaseViewController, UITableViewDelegate, HMUIViewTapDelegate  {
    
    @IBOutlet weak var adContainerView: UIView!
    
    @IBOutlet weak var mainTableView: UITableView!
    private let HMMainItemTableCellNibName = "HMMainItemTableCell"
    private let ScrollSectionBCellID = "ScrollSectionBCellID"    
    private var sectionBUnitSize: CGSize? = CGSize(width: 100, height: 30)
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topTableViewConstraint: NSLayoutConstraint!


    var mainViewModel: HMMainVideoViewModel? = HMMainVideoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Video Banner"
        
        self.view.backgroundColor = UIColor(red: 48/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1)
        self.adContainerView.backgroundColor = UIColor(red: 48/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1)
        
        self.setupRearViewController()
        self.setupTableView()
        self.getMainItems()
    }
    
    deinit {
        print("deinit HMMainVideoViewController")
    }

    func setupRearViewController(){
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        let aSelector: Selector = #selector(SWRevealViewController.revealToggle(_:))
        let revealButtonItem = UIBarButtonItem(image: UIImage(named: "reveal-icon.png"), style: .plain, target: self.revealViewController(), action: aSelector)
        self.navigationItem.leftBarButtonItem = revealButtonItem
    }
    
    func setupTableView(){
        self.mainTableView.backgroundColor =  UIColor(red: 48/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1)
        
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
        
        if let viewModel = viewModel as? HMMainItemUnitTypeBViewModel {
            self.addAdView(viewModel.adCode.value!)
        }
    }
    
    func addAdView(_ adCode: String){
//        self.bannerView?.removeFromSuperview()
//        let con = HotmobiOSSDK.getHotmobBannerController(adCode, needAutoReload: true, delegate: self, identifier: "banner")
//        self.bannerView = con.displayView()
//        self.adContainerView.addSubview(self.bannerView!)
        if let b = self.banner {
            if (adCode == "mute_video") {
                b.muteVideo()
            } else {
                b.hide()
                b.adCode = adCode
                b.loadAd()
            }
        } else {
            self.banner = HotmobController(type: .Banner, identifier: "Banner", adCode: adCode, delegate: self)
            self.banner?.animated = true
            self.adContainerView.addSubview(self.banner!.displayView())
            self.banner?.loadAd()
        }
//        self.lblAdCode.text = adCode
    }
}

extension HMMainVideoViewController: UICollectionViewDelegate{
    
}


extension HMMainVideoViewController: UICollectionViewDataSource{
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

extension HMMainVideoViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let indexCollectionView = collectionView as! HMIndexedCollectionView
        let mainItem = self.mainViewModel?.itemList?.value[0].items[(indexCollectionView.indexPath?.row)!] as! HMMainItemViewModel
        let sectionDisplayType = mainItem.displayType.value
        let size: CGSize
        
        if(sectionDisplayType == "3") {
            size = self.sectionBUnitSize!
        }else {
            size = CGSize.zero
        }
        return size
    }
    
}

extension HMMainVideoViewController: HotmobControllerDelegate{
    func adDidStartLoading(_ ad: HotmobController) {}
    func adDidLoad(_ ad: HotmobController) {}
    func noAd(_ ad: HotmobController) {}
    func adDidShow(_ ad: HotmobController) {
        self.adContainerView.frame.size.height = ad.displayView().frame.size.height
    }
    func adDidHide(_ ad: HotmobController) {
        self.adContainerView.frame.size.height = 0
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
    func adDidResize(_ ad: HotmobController) {}
    
    func deepLinkDidClick(_ ad: HotmobController, _ url: String) {
        let internalLinkVC = HMInternalLinkViewController(url: url)
        self.navigationController?.pushViewController(internalLinkVC, animated: true)
    }
}

extension HMMainVideoViewController {

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

