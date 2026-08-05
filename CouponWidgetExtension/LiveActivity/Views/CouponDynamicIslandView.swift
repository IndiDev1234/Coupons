//
//  CouponDynamicIslandBuilder.swift
//  CouponWidgetExtension
//
//  Created by Vansh Sharma on 05/08/26.
//

import SwiftUI
import WidgetKit
import ActivityKit

enum CouponDynamicIslandBuilder {

    static func make(
        context: ActivityViewContext<CouponActivityAttributes>
    ) -> DynamicIsland {

        DynamicIsland {

            DynamicIslandExpandedRegion(.leading) {

                HStack(spacing: 6) {
                    Image(systemName: "ticket.fill")
                        .foregroundStyle(.orange)

                    Text(context.state.merchantName)
                        .font(.headline)
                        .lineLimit(1)
                }
            }

            DynamicIslandExpandedRegion(.trailing) {

                Text(context.state.discountText)
                    .font(.headline.bold())
                    .foregroundStyle(.green)
            }

            DynamicIslandExpandedRegion(.bottom) {

                VStack(alignment: .leading, spacing: 10) {

                    HStack {

                        Label(
                            context.state.distance,
                            systemImage: "location.fill"
                        )

                        Spacer()

                        Label(
                            context.state.isNearby ? "Nearby" : "Away",
                            systemImage: context.state.isNearby
                                ? "checkmark.circle.fill"
                                : "clock"
                        )
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {

                        Text("Coupon Code")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text(context.state.couponCode)
                            .font(.title3.monospaced().bold())
                    }

                    Divider()

                    Text(context.state.expiryDate, style: .relative)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

        } compactLeading: {

            Image(systemName: "ticket.fill")
                .foregroundStyle(.orange)

        } compactTrailing: {

            Text(context.state.discountText)
                .font(.caption.bold())

        } minimal: {

            Image(systemName: "ticket.fill")
                .foregroundStyle(.orange)
        }
        .keylineTint(.orange)
    }
}
