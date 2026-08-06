//
//  MerchantResolverProtocol.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation

protocol MerchantResolverProtocol {

    func resolve(
        from text: String
    ) -> MerchantMatch?
}
