//
//  CouponRowView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import SwiftUI

struct CouponRowView: View {

    let coupon: Coupon

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(coupon.merchant?.name ?? "Unknown Merchant")
                .font(.headline)

            Text(coupon.title)
                .font(.title3.bold())

            HStack {

                Text(discountText)

                Spacer()

                if let expiry = coupon.expiryDate {

                    Text(expiry, style: .relative)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .shadow(radius: 2)
    }

    private var discountText: String {

        guard let value = coupon.discountValue else {

            return "Offer"
        }

        switch coupon.discountType {

        case .percentage:
            return "\(Int(value))% OFF"

        case .fixedAmount:
            return "₹\(Int(value)) OFF"

        case .freeItem:
            return "Free Item"
        }
    }
}

#Preview {

    CouponRowView(
        coupon: Coupon(
            title: "Summer Special",
            couponCode: "STAR25",
            discountValue: 25,
            discountType: .percentage
        )
    )
}
