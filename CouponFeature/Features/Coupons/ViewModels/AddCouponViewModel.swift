//
//  AddCouponViewModel.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import Observation

@Observable
final class AddCouponViewModel {

    // MARK: Merchant

    var merchantName = ""

    // MARK: Coupon

    var couponTitle = ""

    var couponCode = ""

    // MARK: Discount

    var discountValue = ""

    var discountType: DiscountType = .percentage

    // MARK: Expiry

    var expiryDate = Date()

    // MARK: Notes

    var notes = ""

}
