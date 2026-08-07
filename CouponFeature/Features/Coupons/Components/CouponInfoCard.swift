//
//  CouponInfoCard.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


//
//  CouponInfoCard.swift
//  CouponFeature
//

import SwiftUI

struct CouponInfoCard: View {

    let coupon: Coupon

    var body: some View {

        VStack(alignment: .leading, spacing: 24) {

            Text("Coupon Information")
                .font(.headline)

            CouponInfoRow(
                title: "Merchant",
                value: coupon.merchant?.name ?? "Unknown"
            )

            CouponInfoRow(
                title: "Discount Type",
                value: discountType
            )

            CouponInfoRow(
                title: "Minimum Purchase",
                value: minimumPurchase
            )

            CouponInfoRow(
                title: "Expiry",
                value: expiryText
            )

            CouponInfoRow(
                title: "Category",
                value: coupon.merchant?.category.displayName ?? "Other"
            )

            if let notes = coupon.notes,
               !notes.isEmpty {

                Divider()

                VStack(alignment: .leading, spacing: 8) {

                    Text("Notes")
                        .font(.subheadline.bold())

                    Text(notes)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 24
            )
        )
    }
}

private extension CouponInfoCard {

    var discountType: String {

        switch coupon.discountType {

        case .percentage:
            return "Percentage"

        case .fixedAmount:
            return "Fixed Amount"

        case .freeItem:
            return "Free Item"
        }
    }

    var minimumPurchase: String {

        guard let value = coupon.minimumPurchase else {

            return "None"
        }

        return "₹\(Int(value))"
    }

    var expiryText: String {

        guard let expiry = coupon.expiryDate else {

            return "No Expiry"
        }

        return expiry.formatted(
            date: .abbreviated,
            time: .omitted
        )
    }
}