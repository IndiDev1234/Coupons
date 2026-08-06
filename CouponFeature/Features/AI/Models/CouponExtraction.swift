//
//  CouponExtraction.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import FoundationModels

@Generable
struct CouponExtraction {

    @Guide(description: "Merchant or brand name")
    var merchant: String?

    @Guide(description: "Coupon title")
    var title: String?

    @Guide(description: "Coupon code")
    var couponCode: String?

    @Guide(description: "Discount type such as percentage, fixed amount or free item")
    var discountType: String?

    @Guide(description: "Numeric discount value")
    var discountValue: Double?

    @Guide(description: "Minimum purchase amount")
    var minimumPurchase: Double?

    @Guide(description: "Coupon expiry date in ISO-8601 format")
    var expiryDate: String?

    @Guide(description: "Short summary of the terms and conditions")
    var termsSummary: String?

    @Guide(description: "Confidence score between 0 and 1")
    var confidence: Double?
}
