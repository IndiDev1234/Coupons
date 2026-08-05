//
//  CouponLockScreenView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//


import SwiftUI
import ActivityKit
import WidgetKit

struct CouponLockScreenView: View {

    let context: ActivityViewContext<CouponActivityAttributes>

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            // MARK: Header

            HStack(alignment: .center) {

                Image(systemName: "ticket.fill")
                    .font(.title2)
                    .foregroundStyle(.orange)

                VStack(alignment: .leading, spacing: 4) {

                    Text(context.state.merchantName)
                        .font(.headline)

                    Text(context.state.couponTitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text(context.state.discountText)
                    .font(.title3.bold())
                    .foregroundStyle(.green)
            }

            Divider()

            VStack(alignment: .leading, spacing: 6) {

                Text("Coupon Code")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(context.state.couponCode)
                    .font(.title2.monospaced())
                    .bold()
            }

            Divider()

            HStack {

                Label(
                    context.state.distance,
                    systemImage: "location.fill"
                )

                Spacer()

                Label {

                    Text(
                        context.state.expiryDate,
                        style: .relative
                    )

                } icon: {

                    Image(systemName: "clock")
                }
            }
            .font(.caption)
            .foregroundStyle(.secondary)

        }
        .padding()
    }
}
