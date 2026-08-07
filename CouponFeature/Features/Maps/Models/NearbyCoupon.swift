//
//  NearbyCoupon.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


import Foundation

struct NearbyCoupon: Identifiable {

    let id = UUID()

    let coupon: Coupon

    let merchantLocation: MerchantLocation

    var distance: Double {

        merchantLocation.distance
    }
}
