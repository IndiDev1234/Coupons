//
//  CouponUsageStatus.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation

enum CouponUsageStatus: String, Codable, CaseIterable {

    case redeemed
    case expired
    case cancelled
}
