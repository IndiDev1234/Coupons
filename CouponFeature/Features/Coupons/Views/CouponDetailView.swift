//
//  CouponDetailView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import SwiftUI

struct CouponDetailView: View {

    let coupon: Coupon

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                CouponListCardView(
                    coupon: coupon
                )

                couponInformation

                notesSection

                Spacer(minLength: 40)
            }
            .padding()
        }
        .navigationTitle("Coupon")
        .navigationBarTitleDisplayMode(.inline)
    }
}
private extension CouponDetailView {

    var couponInformation: some View {

        VStack(alignment: .leading, spacing: 16) {

            Label("Merchant", systemImage: "building.2")

            Text(coupon.merchant?.name ?? "Unknown")

            Divider()

            Label("Coupon Code", systemImage: "ticket")

            Text(coupon.couponCode ?? "No Code")
                .font(.title2.monospaced().bold())

            Divider()

            Label("Discount", systemImage: "tag")

            Text(discountText)

            Divider()

            Label("Expiry", systemImage: "calendar")

            if let expiry = coupon.expiryDate {

                Text(expiry.formatted(date: .abbreviated,
                                      time: .omitted))

            } else {

                Text("No Expiry")
            }

        }
        .padding()
        .background(.background)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }
}
private extension CouponDetailView {

    var notesSection: some View {

        Group {

            if let notes = coupon.notes,
               !notes.isEmpty {

                VStack(alignment: .leading) {

                    Text("Notes")
                        .font(.headline)

                    Text(notes)
                }
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .padding()
                .background(.background)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
            }
        }
    }
}
private extension CouponDetailView {

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
            return "Free Item"
        }
    }
}
