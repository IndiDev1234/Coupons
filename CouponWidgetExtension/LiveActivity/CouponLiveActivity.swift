//
//  CouponLiveActivity.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct CouponLiveActivity: Widget {

    var body: some WidgetConfiguration {

        ActivityConfiguration(
            for: CouponActivityAttributes.self
        ) { context in

            // Lock Screen
            CouponLockScreenView(
                context: context
            )
            .activityBackgroundTint(Color.clear)

        } dynamicIsland: { context in
            CouponDynamicIslandBuilder.make(context: context)
        }
    }
}
