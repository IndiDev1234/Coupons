//
//  CouponSaveError.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation

enum CouponSaveError: LocalizedError {

    case invalidForm
    case missingCouponForEdit

    var errorDescription: String? {

        switch self {

        case .invalidForm:
            return "Please fill in all required fields."

        case .missingCouponForEdit:
            return "Unable to find the coupon to update."
        }
    }
}
