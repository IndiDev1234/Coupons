//
//  CouponActivityAttributes.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//

import ActivityKit
import Foundation

struct CouponActivityAttributes: ActivityAttributes {

    public struct ContentState: Codable, Hashable {

        // MARK: Dynamic Properties

        var merchantName: String

        var couponTitle: String

        var discountText: String

        var couponCode: String

        var expiryDate: Date

        var distance: String

        var isNearby: Bool
    }

    // MARK: Fixed Properties

    let couponID: UUID
}
