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
        expiryDate: Calendar.current.date(
            byAdding: .day,
            value: 2,
            to: Date()
        )!,
        distance: "150 m",
        isNearby: true
    )
}
