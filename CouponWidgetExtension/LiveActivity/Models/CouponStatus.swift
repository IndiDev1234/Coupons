//
//  CouponStatus.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//


import Foundation

enum CouponStatus: String, Codable, CaseIterable {

    case active
    case expiringSoon
    case expired
    case redeemed

    var displayName: String {

        switch self {

        case .active:
            return "Active"

        case .expiringSoon:
            return "Expiring Soon"

        case .expired:
            return "Expired"

        case .redeemed:
            return "Redeemed"
        }
    }
}
