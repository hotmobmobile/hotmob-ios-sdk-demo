//
//  HMRearItemViewModel.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 7/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct HMRearItemViewModel: HMBaseViewModel {
    
    var id: BehaviorRelay<String?> = BehaviorRelay(value: "")
    var displayType: BehaviorRelay<String?> = BehaviorRelay(value: "")
    var displayName: BehaviorRelay<String?> = BehaviorRelay(value: "")
    var catItems: BehaviorRelay<Array<NSDictionary>> = BehaviorRelay(value: [])
    
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
        self.id.accept(model.id ?? "")
        self.displayType.accept(model.displayType ?? "")
        self.displayName.accept(model.displayName ?? "")
        self.catItems.accept(model.catItems ?? [])
    }
}
