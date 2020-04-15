//
//  HMRearItemViewModel.swift
//  HotmobReloadDemo
//
//  Created by Paul Cheung on 8/4/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import Foundation
import RxSwift

struct HMRearItemViewModel: HMBaseViewModel {
    
    var id: Variable<String?> = Variable("")
    var displayType: Variable<String?> = Variable("")
    var displayName: Variable<String?> = Variable("")
    var catItems: Variable<Array<NSDictionary>> = Variable([])
    
    var model: HMRearItemModel? {
        didSet {
            self.setupData(model: model!)
        }
    }
    
    init(model: HMRearItemModel) {
        self.model = model
        self.setupData(model: model)
    }
    
    private func setupData(model: HMRearItemModel) {
        self.id.value = model.id ?? ""
        self.displayType.value = model.displayType ?? ""
        self.displayName.value = model.displayName ?? ""
        self.catItems.value = model.catItems ?? []
    }
}
