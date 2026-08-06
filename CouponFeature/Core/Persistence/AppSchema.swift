//
//  AppSchema.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import SwiftData

enum AppSchema {

    static let schema = Schema([
        Merchant.self,
        Store.self,
        Coupon.self
    ])
}
