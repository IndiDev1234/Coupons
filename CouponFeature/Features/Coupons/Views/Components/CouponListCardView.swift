//
//  CouponCardView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import SwiftUI

struct CouponListCardView: View {

    let coupon: Coupon

    var body: some View {

        VStack(alignment: .leading, spacing: 18) {

            header

            discountSection

            codeSection

            footer
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(cardBackground)
        .overlay(cardBorder)
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
    }
}
private extension CouponListCardView {

    var header: some View {

        HStack {

            VStack(alignment: .leading) {

                Text(coupon.merchant?.name ?? "Merchant")
                    .font(.headline)

                Text(coupon.title)
                    .font(.title3.bold())
            }

            Spacer()

            Image(systemName: "heart")
                .foregroundStyle(.secondary)
        }
    }
}
private extension CouponListCardView {

    var discountSection: some View {

        HStack {

            Text(discountText)
                .font(.title.bold())
                .foregroundStyle(.green)

            Spacer()

            Text(statusText)
                .font(.caption.bold())
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.green.opacity(0.15))
                .clipShape(Capsule())
        }
    }
}
private extension CouponListCardView {

    var codeSection: some View {

        VStack(alignment: .leading, spacing: 6) {

            Text("Coupon Code")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(coupon.couponCode ?? "No Code")
                .font(.title3.monospaced().bold())
        }
    }
}
private extension CouponListCardView {

    var footer: some View {

        HStack {

            Label("Nearby", systemImage: "location.fill")

            Spacer()

            if let expiry = coupon.expiryDate {

                Text(expiry, style: .relative)
            }
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }
}
private extension CouponListCardView {

    var cardBackground: some View {

        RoundedRectangle(cornerRadius: 24)
            .fill(.background)
    }

    var cardBorder: some View {

        RoundedRectangle(cornerRadius: 24)
            .strokeBorder(.quaternary)
    }
}
private extension CouponListCardView {

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

    var statusText: String {

        if coupon.isRedeemed {
            return "USED"
        }

        if let expiry = coupon.expiryDate,
           expiry < .now {
            return "EXPIRED"
        }

        return "ACTIVE"
    }
}
