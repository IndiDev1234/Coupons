//
//  CouponActivityPreview.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//

import SwiftUI
import WidgetKit
import ActivityKit

#Preview(
    "Coupon",
    as: .content,
    using: MockCouponActivity.attributes
) {

    CouponLiveActivity()

} contentStates: {

    MockCouponActivity.state
}
