//
//  NearbyCoupon.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


//
//  NearbyCoupon.swift
//  CouponFeature
//

import Foundation
import CoreLocation

struct NearbyCoupon: Identifiable {

    // MARK: - Properties

    let id = UUID()

    let coupon: Coupon

    let merchantLocation: MerchantLocation

    // MARK: - Computed

    var distance: CLLocationDistance {

        merchantLocation.distance
    }

    /// Maximum distance at which we trigger
    /// Live Activities and Notifications.
    static let triggerRadius: CLLocationDistance = 300

    /// Whether this coupon is close enough to
    /// notify the user.
    var isWithinTriggerRadius: Bool {

        distance <= Self.triggerRadius
    }

    /// User-friendly distance text.
    var distanceText: String {

        if distance < 1000 {

            return "\(Int(distance)) m"
        }

        return String(
            format: "%.1f km",
            distance / 1000
        )
    }

    /// Used to prioritize coupons.
    var priority: NearbyCouponPriority {

        if distance <= 100 {
            return .immediate
        }

        if distance <= Self.triggerRadius {
            return .nearby
        }

        return .far
    }
}

enum NearbyCouponPriority: Int, Comparable {

    case immediate = 0
    case nearby = 1
    case far = 2

    static func < (
        lhs: NearbyCouponPriority,
        rhs: NearbyCouponPriority
    ) -> Bool {

        lhs.rawValue < rhs.rawValue
    }
}
