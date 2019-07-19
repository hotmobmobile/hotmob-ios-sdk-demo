//
//  HMRearViewModel.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 7/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class HMRearViewModel {
    var itemList: Variable<[SectionModel<String, HMRearCatItemViewModel>]>? = Variable([])
    
    func getLocalJSONRear() -> Observable<[SectionModel<String, HMRearCatItemViewModel>]> {
        
        return Observable.create{ (observer) in
            
            let path = HMResourcesLoader.frameworkBundle().path(forResource: "RearJson.js", ofType: "")
            let jsonString = try? String(contentsOfFile: path!)
            let jsonData = jsonString?.data(using: .utf8)
            let responseDict: NSDictionary = try! JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers) as! NSDictionary
            
            let contentDict: NSDictionary = responseDict.object(forKey: "data") as! NSDictionary
            
            if contentDict != nil {
                var tmpItemList: [SectionModel<String, HMRearCatItemViewModel>] = []
                var catItemsList: [HMRearCatItemViewModel] = []
                let itemsList: NSArray = contentDict.object(forKey: "items") as! NSArray
                
                for item in itemsList as! [NSDictionary] {
                    let sectionTitle: String = item.object(forKey: "displayName") as! String
                    
                    var catViewModel: HMRearCatItemViewModel?
                    if let cats = item.object(forKey: "catItems") as? NSArray {
                        for cat in cats {
                            let catString: String? = HMUtilities.objectToString(object: cat)
                            let catModel = HMRearCatItemModel(JSONString: catString!)
                            catViewModel = HMRearCatItemViewModel(model: catModel!)
                            
                            catItemsList.append(catViewModel!)
                        }
                        if catItemsList.count > 0{
                            tmpItemList.append(SectionModel(model: sectionTitle, items: catItemsList))
                        }
                        catItemsList = []
                    }
                    
                }
                
                self.itemList?.value = tmpItemList
                observer.onNext((self.itemList?.value)!)
                observer.onCompleted()
            }
            else{
            }
            return Disposables.create()
        }
    }
}
