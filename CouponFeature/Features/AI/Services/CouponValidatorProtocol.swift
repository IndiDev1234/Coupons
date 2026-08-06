//
//  CouponValidator.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation

protocol CouponValidatorProtocol {

    func validate(
        _ extraction: CouponExtraction
    ) throws
}
