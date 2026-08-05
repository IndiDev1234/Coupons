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

        var merchantName: String
        var couponTitle: String
        var discountText: String
        var couponCode: String
        var distance: String
        var expiryDate: Date

        var status: CouponStatus
    }

    // MARK: - Fixed Properties

    let couponID: UUID
}
