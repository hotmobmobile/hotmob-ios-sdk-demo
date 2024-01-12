//
//  HMFloatingViewController.swift
//  HotmobiOSSDKDemo
//
//  Created by Kailey Chan on 21/9/2023.
//  Copyright © 2023 Paul Cheung. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SWRevealViewController

import AppTrackingTransparency
import AdSupport

import CoreLocation
import HotmobiOSSDK


class HMFloatingViewController: HMBaseViewController, UITableViewDelegate, HMUIViewTapDelegate  {
    
    //    var bannerView: UIView?
        @IBOutlet weak var lblAdCode: UILabel!
        @IBOutlet weak var contentView: UIView!
        @IBOutlet weak var lblBGView: UIView!
        @IBOutlet weak var mainTableView: UITableView!
        @IBOutlet weak var scrollView: UIScrollView!
        @IBOutlet weak var textView: UITextView!
    

        private let HMMainItemTableCellNibName = "HMMainItemTableCell"
        private let ScrollSectionACellID = "ScrollSectionACellID"
        private let ScrollSectionBCellID = "ScrollSectionBCellID"

        private var sectionAUnitSize: CGSize?
        private var sectionBUnitSize: CGSize?
        
        var locationManager: CLLocationManager?
        
        @IBOutlet weak var heightConstraint: NSLayoutConstraint!
        
        @IBOutlet weak var adContainerheightConstraint: NSLayoutConstraint!


        var mainViewModel: HMFloatingViewModel? = HMFloatingViewModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Floating Banner"
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
            
            self.contentView.backgroundColor = UIColor(red: 48/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1)
            
            self.setupRearViewController()
            self.setupSectionUnits()
            self.setupTableView()
            self.getMainItems()
            
            self.textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean volutpat tellus a feugiat iaculis. Sed vel risus non mi aliquam consequat. Pellentesque pretium nunc vitae sem viverra, lacinia dictum tellus lobortis. Proin lectus elit, malesuada quis ultrices eget, porta in ligula. Aliquam risus dui, congue vitae auctor sit amet, pharetra non enim. Integer convallis orci at libero pretium facilisis. Nam vestibulum urna ac turpis viverra, auctor maximus tortor ornare. Quisque vel efficitur felis. Pellentesque a metus ut sapien condimentum pellentesque. Aenean interdum libero a quam congue dictum. Praesent ullamcorper venenatis consequat. Suspendisse commodo lacinia interdum. Quisque rhoncus tellus nec ultrices vulputate. Nunc et diam id tortor ullamcorper lacinia. Aenean ut tincidunt nibh. Suspendisse condimentum sit amet metus vel lobortis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Quisque quis ultricies purus, in porta lectus. Donec egestas libero et justo aliquet eleifend. Praesent sapien risus, tincidunt quis eleifend in, dictum at eros. Aliquam erat volutpat. Nunc tellus erat, tempus vitae eros non, luctus auctor tortor. Donec eros elit, dictum eu convallis at, sollicitudin id ipsum. Nullam tincidunt feugiat dapibus. Pellentesque lectus mauris, feugiat sed justo vitae, aliquam tempor nunc. Vivamus vel molestie mi, ut euismod leo. Quisque sed diam sodales, scelerisque diam sit amet, feugiat lorem. Aenean sodales accumsan blandit. Sed sed elit nec nibh laoreet ultricies non eget metus. Etiam ac ultrices ipsum, quis laoreet mauris. Suspendisse luctus ac turpis in pharetra. Suspendisse efficitur tortor nibh, dictum egestas nisi cursus in. Vestibulum mattis sit amet ligula ultrices ultrices. Sed semper sodales nulla, nec lacinia nibh consequat et. Morbi odio sapien, tristique sit amet sollicitudin at, faucibus ut nibh. Nullam dapibus neque ut ex laoreet, vel feugiat magna tempor. Ut metus quam, pretium nec venenatis ut, auctor nec tellus. Fusce pellentesque aliquet volutpat. Sed laoreet tortor non sapien malesuada, vel fermentum neque ultricies. Maecenas luctus ornare elit vel malesuada. Donec in ultricies nulla, et commodo lorem. Duis ullamcorper, nunc eget facilisis tincidunt, eros ex tincidunt lacus, sit amet sollicitudin nulla ipsum quis orci. Morbi bibendum risus ac ipsum rutrum euismod. Proin eget turpis sit amet lacus iaculis blandit sit amet sed ex. Aliquam luctus tellus non risus scelerisque, ornare congue libero dictum. Maecenas vitae lacus at ipsum pharetra facilisis quis id odio. Nulla gravida nunc leo, sed varius diam mollis eget. Maecenas id lacus a turpis dictum fermentum ut eget libero. Fusce hendrerit semper felis eu lacinia. Donec ut erat sodales, hendrerit arcu non, condimentum quam. Nunc ut mauris vel libero sollicitudin semper. Nunc blandit elit eu ante sagittis mattis. Curabitur mollis neque dui, at ullamcorper sapien scelerisque id. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aliquam suscipit nulla finibus, volutpat sem in, lobortis enim. Quisque rhoncus dui eu felis imperdiet efficitur. Quisque eu massa ut leo dignissim vehicula. Aliquam vel erat id est ullamcorper consectetur. In fringilla enim in tincidunt condimentum. Mauris semper nulla sem. Etiam magna ex, consectetur a laoreet nec, euismod dictum ligula. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse purus nibh, fringilla eu porttitor id, varius sed leo. Integer in pellentesque eros. Fusce condimentum mi urna, quis faucibus tellus pharetra sed. Cras consectetur pulvinar bibendum. Quisque nibh enim, tempus vitae libero eget, posuere hendrerit dolor. Ut commodo dolor metus, sed consectetur urna posuere in. Sed laoreet mauris in neque mollis, id placerat urna tristique. Vestibulum a felis vulputate, rutrum felis nec, accumsan libero. Sed vestibulum eros diam, eget varius erat sodales eu. Nam mollis risus tempus, lobortis orci sit amet, vulputate urna. Vestibulum iaculis leo elit, nec aliquet dui auctor in. Nullam eleifend posuere augue, commodo aliquet lacus. Nunc porttitor velit ex, fermentum tempor mi bibendum ac. Cras sagittis ligula a urna egestas, in dapibus lacus luctus. Curabitur molestie et mauris id fringilla. Etiam dignissim maximus dui non tincidunt. Nunc tincidunt tincidunt commodo. Proin quis ante interdum nunc malesuada tempor non sed ligula. Cras volutpat enim sed ex hendrerit ornare. Donec pharetra accumsan nulla id eleifend. Etiam eget orci tellus. Donec non enim tincidunt, convallis turpis eu, iaculis neque. Integer rutrum arcu eu tortor cursus, pellentesque auctor massa elementum. Cras viverra ultrices tellus, sit amet mattis enim lacinia vel. Nunc ut mollis lectus, quis tristique nisi. Pellentesque pellentesque tortor ac pharetra luctus. Vivamus porta lorem ac arcu convallis laoreet. Integer eros lorem, eleifend at ultricies nec, faucibus ut eros. Nullam sit amet velit in lacus mattis dignissim ac eu neque. Aenean tortor ligula, convallis pharetra sodales nec, aliquet ut lorem. Mauris quis laoreet risus, quis porttitor nisl. Ut arcu massa, rhoncus eget tempus hendrerit, tristique consequat urna. Aliquam et ligula vitae nisl tincidunt aliquet non sed est. Integer pellentesque augue nec nunc commodo feugiat a vel quam. Nullam vitae lacus sit amet nisl porta maximus. Phasellus rhoncus odio sit amet dictum dictum. Nam et turpis sollicitudin, condimentum neque ac, facilisis leo. Vestibulum congue cursus eleifend. Quisque et auctor lacus, in dapibus turpis. Phasellus sollicitudin consectetur massa vitae mollis. Fusce finibus feugiat ornare. Donec a fringilla lorem. Fusce augue nisl, congue a mi quis, egestas suscipit massa. Morbi at imperdiet urna. Duis arcu arcu, scelerisque nec nisl non, placerat cursus quam. Praesent finibus ipsum lacus, sed ullamcorper metus suscipit nec. Cras bibendum tristique dui, a luctus mi consectetur ac. Cras lectus eros, tincidunt et pellentesque sit amet, pharetra ut tortor. Sed sit amet consequat dui. Mauris finibus mollis lectus, ut iaculis mauris pulvinar sed. Sed quis est nec urna iaculis cursus non sagittis turpis. Nulla vel ligula eros. Nunc pulvinar sem eget lacus ullamcorper sollicitudin. Vivamus volutpat, arcu sagittis interdum lobortis, nisi ante rhoncus tortor, in maximus libero turpis sed nulla. Morbi tellus est, porta sed congue eu, luctus in magna. Nam id ex feugiat, hendrerit diam congue, interdum ipsum. Suspendisse potenti. Donec posuere maximus est eu viverra. Cras cursus justo non nunc fermentum, ac hendrerit ipsum sagittis. Pellentesque molestie, urna quis tempus posuere, tortor erat blandit orci, in imperdiet nisi est ut mauris. Suspendisse aliquet bibendum scelerisque. Sed auctor ex."
            
            self.textView.sizeToFit()
            
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
            if let b = self.banner {
                b.hide()
                b.adCode = adCode
                b.loadAd()
            } else {
                let banner = HotmobController(type: .Banner, identifier: "Floating", adCode: adCode, delegate: self)
                banner.animated = false
                banner.containsInView = self.view
                self.view.addSubview(banner.displayView())
                banner.loadAd()
                self.banner = banner
            }
            self.lblAdCode.text = adCode
        }
    }


    extension HMFloatingViewController: UICollectionViewDelegate{

    }


    extension HMFloatingViewController: UICollectionViewDataSource{
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

    extension HMFloatingViewController: UICollectionViewDelegateFlowLayout{
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

    extension HMFloatingViewController: UIScrollViewDelegate{
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
        }
    }

    extension HMFloatingViewController: HotmobControllerDelegate{
        func adDidStartLoading(_ ad: HotmobController) {}
        func adDidLoad(_ ad: HotmobController) {}
        func noAd(_ ad: HotmobController) {
            self.lblAdCode.text = "No Ad Return"
        }
        func adDidShow(_ ad: HotmobController) {}
        func adDidHide(_ ad: HotmobController) {}
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
        }
        
        func deepLinkDidClick(_ ad: HotmobController, _ url: String) {
            let internalLinkVC = HMInternalLinkViewController(url: url)
            self.navigationController?.pushViewController(internalLinkVC, animated: true)
        }
    }

    extension HMFloatingViewController {

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
