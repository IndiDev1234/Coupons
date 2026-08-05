//
//  CouponStatus.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//


import Foundation

enum CouponStatus: String, Codable {

    case active
    case expiringSoon
    case expired
    case redeemed
}
