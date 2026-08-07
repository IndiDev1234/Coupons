//
//  CouponDetailViewModel.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


//
//  CouponDetailViewModel.swift
//  CouponFeature
//

import Foundation
import Observation
import SwiftData

@Observable
@MainActor
final class CouponDetailViewModel {

    let coupon: Coupon

    init(coupon: Coupon) {

        self.coupon = coupon
    }

    func toggleFavorite(
        using context: ModelContext
    ) throws {

        coupon.isFavorite.toggle()

        try context.save()
    }

    func toggleRedeemed(
        using context: ModelContext
    ) throws {

        coupon.isRedeemed.toggle()

        try context.save()
    }
}