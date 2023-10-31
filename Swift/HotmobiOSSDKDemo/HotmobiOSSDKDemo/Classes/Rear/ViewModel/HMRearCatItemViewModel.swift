//
//  HMRearCatItemViewModel.swift
//  HotmobiOSSDKDemo
//
//  Created by Paul Cheung on 7/3/2019.
//  Copyright © 2019 Paul Cheung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct HMRearCatItemViewModel: HMBaseViewModel {
    
    var id: BehaviorRelay<String?> = BehaviorRelay(value: "")
    var display: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var title: BehaviorRelay<String?> = BehaviorRelay(value: "")
    
    var model: HMRearCatItemModel? {
        didSet {
            self.setupData(model: model!)
        }
    }
    
    init(model: HMRearCatItemModel) {
        self.model = model
        self.setupData(model: model)
    }
    
    private func setupData(model: HMRearCatItemModel) {
        self.id.accept(model.id ?? "")
        self.display.accept(model.display ?? false)
        self.title.accept(model.title ?? "")
    }
}
