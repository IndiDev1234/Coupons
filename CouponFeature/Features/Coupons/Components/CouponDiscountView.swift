//
//  CouponDiscountView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


import SwiftUI

struct CouponDiscountView: View {

    let value: Double?

    let type: DiscountType

    private var primaryText: String {

        switch type {

        case .percentage:

            guard let value else {
                return "--"
            }

            return "\(Int(value))%"

        case .fixedAmount:

            guard let value else {
                return "--"
            }

            return "₹\(Int(value))"

        case .freeItem:

            return "FREE"
        }
    }

    private var secondaryText: String {

        switch type {

        case .percentage,
             .fixedAmount:

            return "OFF"

        case .freeItem:

            return "ITEM"
        }
    }

    var body: some View {

        VStack(spacing: 4) {

            Text(primaryText)
                .font(.system(size: 44, weight: .bold))
                .contentTransition(.numericText())

            Text(secondaryText)
                .font(.headline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {

    VStack(spacing: 40) {

        CouponDiscountView(
            value: 20,
            type: .percentage
        )

        CouponDiscountView(
            value: 500,
            type: .fixedAmount
        )

        CouponDiscountView(
            value: nil,
            type: .freeItem
        )
    }
    .padding()
}
