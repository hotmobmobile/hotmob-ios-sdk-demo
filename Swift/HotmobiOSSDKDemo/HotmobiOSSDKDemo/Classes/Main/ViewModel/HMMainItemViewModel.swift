//
//  HMMainItemViewModel.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 4/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import Foundation
import RxSwift

struct HMMainItemViewModel: HMBaseViewModel {

    var id: Variable<String?> = Variable("")
    var displayType: Variable<String?> = Variable("")
    var itemUnitList: Variable<[HMBaseViewModel]?> = Variable([])
        
    var model: HMMainMenuModel? {
        didSet {
            self.setupData(model: model!)
        }
    }
    
    init(model: HMMainMenuModel) {
        self.model = model
        self.setupData(model: model)
    }
    
    private mutating func setupData(model: HMMainMenuModel) {
        self.id.value = model.id ?? ""
        self.displayType.value = model.displayType ?? ""
        
        var unitList: [HMBaseViewModel] = []
        for i in 0..<(model.items?.count)!
        {
            let rootItem = model.items?[i]

            if model.displayType == "1"
            {
                let id: String = ((rootItem as AnyObject).object(forKey: "id") as? String) ?? ""
                let title: String = ((rootItem as AnyObject).object(forKey: "title") as? String) ??  ""
                let display: Bool = ((rootItem as AnyObject).object(forKey: "display") as? Bool) ??  false

                if display {
                    let obj: HMBaseViewModel = HMMainItemUnitTypeAViewModel(id: id, title: title, display: display)
                    unitList.append(obj)
                }
            }
            else if model.displayType == "2"
            {
                //MARK: textfield for input adCode
            }
            else if model.displayType == "3"
            {
                let id: String = ((rootItem as AnyObject).object(forKey: "id") as? String) ?? ""
                let title: String = ((rootItem as AnyObject).object(forKey: "title") as? String) ??  ""
                let display: Bool = ((rootItem as AnyObject).object(forKey: "display") as? Bool) ??  false
                let adCode: String = ((rootItem as AnyObject).object(forKey: "adCode") as? String) ??  ""
                
                if display {
                    let obj: HMBaseViewModel = HMMainItemUnitTypeBViewModel(id: id, title: title, display: display, adCode: adCode)
                    unitList.append(obj)
                }
            }
        }
        
        self.itemUnitList.value = unitList

    }

}
