//
//  CouponAnnotation.swift
//

import Foundation
import CoreLocation

struct CouponAnnotation: Identifiable, Hashable {

    let id: UUID

    let coupon: Coupon

    let merchantLocation: MerchantLocation

    static func == (
        lhs: CouponAnnotation,
        rhs: CouponAnnotation
    ) -> Bool {

        lhs.id == rhs.id
    }

    func hash(
        into hasher: inout Hasher
    ) {

        hasher.combine(id)
    }

    var coordinate: CLLocationCoordinate2D {

        merchantLocation.coordinate
    }

    var title: String {

        coupon.title
    }

    var merchantName: String {

        coupon.merchant?.name ?? ""
    }

    var distance: Double {

        merchantLocation.distance
    }
}
