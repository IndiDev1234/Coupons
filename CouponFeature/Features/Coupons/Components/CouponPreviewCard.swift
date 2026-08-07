//
//  CouponPreviewCard.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

//
//  CouponPreviewCard.swift
//

import SwiftUI

struct CouponPreviewCard: View {

    let configuration: CouponPreviewConfiguration

    var body: some View {

        ZStack {

            CouponBackground()

            VStack(spacing: 20) {

                VStack(spacing: 6) {

                    Text(configuration.merchant)
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    Text(configuration.title)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                }

                CouponDiscountView(
                    value: configuration.discountValue,
                    type: configuration.discountType
                )

                CouponCodeView(
                    code: configuration.couponCode
                )

                if let expiry = configuration.expiryDate {

                    Label {

                        Text(expiry.formatted(
                            date: .abbreviated,
                            time: .omitted
                        ))

                    } icon: {

                        Image(systemName: "calendar")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }

                CouponStatusChip(
                    expiryDate: configuration.expiryDate,
                    isRedeemed: configuration.isRedeemed
                )
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 360)
    }
}

#Preview {

    CouponPreviewCard(
        configuration: CouponPreviewConfiguration(
            merchant: "Starbucks",
            title: "Summer Special",
            couponCode: "SAVE20",
            discountValue: 20,
            discountType: .percentage,
            expiryDate: .now.addingTimeInterval(86400 * 5),
            isFavorite: true,
            isRedeemed: false,
            aiConfidence: 0.97
        )
    )
    .padding()
}
