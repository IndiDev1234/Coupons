//
//  CouponPreviewConfiguration.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation

struct CouponPreviewConfiguration {

    var merchant: String

    var title: String

    var couponCode: String

    var discountValue: Double?

    var discountType: DiscountType

    var expiryDate: Date?

    var isFavorite: Bool = false

    var isRedeemed: Bool = false

    var aiConfidence: Double?
}
