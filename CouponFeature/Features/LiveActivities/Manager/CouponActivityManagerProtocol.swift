//
//  CouponActivityManagerProtocol.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


import Foundation

@MainActor
protocol CouponActivityManagerProtocol {

    func start(
        for coupon: Coupon
    ) async throws

    func update(
        for coupon: Coupon
    ) async throws

    func end(
        couponID: UUID
    ) async
}
