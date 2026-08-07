//
//  CouponMapAnnotationView.swift
//

import SwiftUI

struct CouponMapAnnotationView: View {

    let annotation: CouponAnnotation

    var body: some View {

        VStack(spacing: 0) {

            VStack(spacing: 4) {

                Text(discountText)
                    .font(.headline.bold())

                Text(annotation.merchantName)
                    .font(.caption2)
                    .lineLimit(1)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 16
                )
            )
            .shadow(radius: 4)

            Image(systemName: "mappin")
                .font(.title2)
                .foregroundStyle(.red)
                .offset(y: -3)
        }
    }
}

private extension CouponMapAnnotationView {

    var discountText: String {

        guard let value = annotation.coupon.discountValue else {

            return "Offer"
        }

        switch annotation.coupon.discountType {

        case .percentage:

            return "\(Int(value))% OFF"

        case .fixedAmount:

            return "₹\(Int(value)) OFF"

        case .freeItem:

            return "FREE"
        }
    }
}
