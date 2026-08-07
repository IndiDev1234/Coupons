//
//  NearbyCouponEngineProtocol.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


import Foundation

@MainActor
protocol NearbyCouponEngineProtocol {

    func nearbyCoupons(
        from coupons: [Coupon]
    ) async throws -> [NearbyCoupon]
}
