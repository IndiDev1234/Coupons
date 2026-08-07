//
//  CouponActivityState.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation

struct CouponActivityState: Codable, Hashable {

    var merchant: String

    var title: String

    var couponCode: String

    var discountText: String

    var expiryDate: Date

    var status: CouponStatus
}
