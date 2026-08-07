//
//  CouponDuplicateServiceProtocol.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


//
//  CouponDuplicateServiceProtocol.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation

protocol CouponDuplicateServiceProtocol {

    func findDuplicate(
        for draft: CouponDraft,
        in coupons: [Coupon]
    ) -> DuplicateMatch?
}