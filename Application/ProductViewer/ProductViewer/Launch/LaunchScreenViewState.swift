//
//  LaunchScreenViewState.swift
//  ProductViewer
//
//  Created by David Truong on 8/27/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

struct LaunchScreenViewState: TempoViewState {
    var launchScreenItem: LaunchScreenItemViewState
}

struct LaunchScreenItemViewState: TempoViewStateItem {
    let image: UIImage?
}
