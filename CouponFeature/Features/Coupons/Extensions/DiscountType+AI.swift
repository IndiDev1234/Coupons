//
//  DiscountType+AI.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation

extension DiscountType {

    static func fromAI(
        _ value: String?
    ) -> DiscountType {

        guard let value else {
            return .percentage
        }

        switch value
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased() {

        case "percentage",
             "%",
             "percent":
            return .percentage

        case "fixed",
             "fixed amount",
             "fixedamount",
             "amount":
            return .fixedAmount

        case "free item",
             "freeitem",
             "bogo",
             "buy one get one":
            return .freeItem

        default:
            return .percentage
        }
    }
}
