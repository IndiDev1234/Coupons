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

        VStack(alignment: .leading, spacing: 12) {

            HStack {

                Image(systemName: "ticket.fill")
                    .font(.title2)

                VStack(alignment: .leading) {

                    Text(context.state.merchantName)
                        .font(.headline)

                    Text(context.state.couponTitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text(context.state.discountText)
                    .font(.title3.bold())
            }

            Divider()

            VStack(alignment: .leading, spacing: 8) {

                Text("Coupon Code")
                    .font(.caption)

                Text(context.state.couponCode)
                    .font(.title2.monospaced())
            }

            Divider()

            HStack {

                Label(
                    context.state.distance,
                    systemImage: "location.fill"
                )

                Spacer()

                Text(
                    context.state.expiryDate,
                    style: .timer
                )
            }
            .font(.caption)
        }
        .padding()
    }
}
