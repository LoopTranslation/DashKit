//
//  DeliveryUncertaintyRecoveryViewModel.swift
//  DashKitUI
//
//  Created by Pete Schwamb on 8/25/20.
//  Copyright © 2020 Tidepool. All rights reserved.
//

import Foundation
import DashKit
import LoopKit

class DeliveryUncertaintyRecoveryViewModel: PumpManagerStatusObserver {
    
    let appName: String
    let uncertaintyStartedAt: Date
    
    var onDismiss: (() -> Void)?
    var didRecover: (() -> Void)?
    var onDeactivate: (() -> Void)?
    
    private var finished = false
    
    init(appName: String, uncertaintyStartedAt: Date) {
        self.appName = appName
        self.uncertaintyStartedAt = uncertaintyStartedAt
    }

    func pumpManager(_ pumpManager: PumpManager, didUpdate status: PumpManagerStatus, oldStatus: PumpManagerStatus) {
        if !finished {
            if !status.deliveryIsUncertain {
                didRecover?()
            }
        }
    }
    
    func podDeactivationChosen() {
        finished = true
        self.onDeactivate?()
    }
}
