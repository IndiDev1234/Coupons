//
//  CouponHeroCard.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


//
//  CouponHeroCard.swift
//  CouponFeature
//

import SwiftUI

struct CouponHeroCard: View {

    let coupon: Coupon

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            HStack {

                VStack(alignment: .leading, spacing: 8) {

                    Text(coupon.merchant?.name ?? "Merchant")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    Text(coupon.title)
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.leading)
                }

                Spacer()

                CouponStatusBadge(
                    status: couponStatus
                )
            }

            Divider()

            HStack {

                VStack(alignment: .leading, spacing: 6) {

                    Text("Discount")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(discountText)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(.green)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 6) {

                    Text("Expires")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    if let expiry = coupon.expiryDate {

                        Text(
                            expiry,
                            format: .dateTime.day().month().year()
                        )
                        .font(.headline)

                    } else {

                        Text("No Expiry")
                            .font(.headline)
                    }
                }
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 28
            )
        )
    }
}

private extension CouponHeroCard {

    var discountText: String {

        guard let value = coupon.discountValue else {

            return "Offer"
        }

        switch coupon.discountType {

        case .percentage:
            return "\(Int(value))% OFF"

        case .fixedAmount:
            return "₹\(Int(value)) OFF"

        case .freeItem:
            return "FREE ITEM"
        }
    }

    var couponStatus: CouponStatus {

        if coupon.isRedeemed {

            return .redeemed
        }

        if let expiry = coupon.expiryDate {

            if expiry < .now {

                return .expired
            }

            if Calendar.current.dateComponents(
                [.day],
                from: .now,
                to: expiry
            ).day ?? 100 <= 3 {

                return .expiringSoon
            }
        }

        return .active
    }
}