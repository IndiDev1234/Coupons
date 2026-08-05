//
//  MockCouponActivity.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//

import Foundation

enum MockCouponActivity {

    static let attributes = CouponActivityAttributes(
        couponID: UUID()
    )

    static let state = CouponActivityAttributes.ContentState(
        merchantName: "Starbucks",
        couponTitle: "Summer Special",
        discountText: "25% OFF",
        couponCode: "STAR25",
        distance: "250 m",
        expiryDate: .now.addingTimeInterval(86400 * 3),
        status: .active
    )
}
