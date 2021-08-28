//
//  LaunchScreenPresenter.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

class LaunchScreenPresenter: TempoPresenter {
    
    let launchScreenView: LaunchScreenView
    
    var dispatcher: Dispatcher?

    required init(launchScreenView: LaunchScreenView) {
        self.launchScreenView = launchScreenView
    }
    
    func present(_ viewState: LaunchScreenViewState) {
        launchScreenView.configureView(viewState)
    }
    
}
