//
//  HMHTMLInterstitialViewController.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 15/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SWRevealViewController
import HotmobiOSSDK

class HMHTMLInterstitialViewController: HMBaseViewController, UITableViewDelegate, HMUIViewTapDelegate{
    
    @IBOutlet weak var mainTableView: UITableView!
    private let HMMainItemTableCellNibName = "HMMainItemTableCell"
    private let ScrollSectionBCellID = "ScrollSectionBCellID"
    private var sectionBUnitSize: CGSize? = CGSize(width: 100, height: 30)
    
    var mainViewModel: HMMainInterstititalViewModel? = HMMainInterstititalViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HTML Interstitial"
        // Do any additional setup after loading the view.
        
        
        self.view.backgroundColor = UIColor(red: 48/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1)
        
        self.setupRearViewController()
        self.setupTableView()
        self.getMainItems()
    }
    
    deinit{
        print("deinit HMHTMLInterstitialViewController")
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
        let popupAdCode = adCode
        HotmobiOSSDK.getHotmobPopup(adCode: popupAdCode, delegate: self)

    }
    
}

extension HMHTMLInterstitialViewController: UICollectionViewDataSource{
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

extension HMHTMLInterstitialViewController: UICollectionViewDelegateFlowLayout{
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

extension HMHTMLInterstitialViewController: HotmobControllerDelegate{
    func didLoadBanner(_ banner: UIView) {
    }
    
    func willDisplayBanner(_ banner: UIView) {
    }
    
    func didDisplayBanner(_ banner: UIView) {
    }
    
    func willHideBanner(_ banner: UIView) {
    }
    
    func didHideBanner(_ banner: UIView) {
    }
    
    func didLoadFailed() {
    }
    
    func openInternalCallback(url: String) {
        let internalLinkVC = HMInternalLinkViewController(url: url)
        self.navigationController?.pushViewController(internalLinkVC, animated: true)
    }
    
    func didResizeBanner(_ banner: UIView) {
        
    }
}
