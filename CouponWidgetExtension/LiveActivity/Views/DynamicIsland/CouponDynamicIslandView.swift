//
//  CouponDynamicIslandBuilder.swift
//  CouponWidgetExtension
//
//  Created by Vansh Sharma on 05/08/26.
//

import SwiftUI
import WidgetKit
import ActivityKit

enum CouponDynamicIslandBuilder {

    static func make(
        context: ActivityViewContext<CouponActivityAttributes>
    ) -> DynamicIsland {

        DynamicIsland {

            DynamicIslandExpandedRegion(.bottom) {
                ExpandedView(context: context)
            }

        } compactLeading: {

            CompactLeadingView()

        } compactTrailing: {

            CompactTrailingView(
                discount: context.state.discountText
            )

        } minimal: {

            MinimalView()
        }
        .keylineTint(ActivityColors.warning)
    }
}
