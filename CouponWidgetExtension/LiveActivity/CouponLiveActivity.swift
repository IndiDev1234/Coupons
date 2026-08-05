//
//  CouponLiveActivity.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct CouponLiveActivity: Widget {

    var body: some WidgetConfiguration {

        ActivityConfiguration(
            for: CouponActivityAttributes.self
        ) { context in

            // Lock Screen
            CouponLockScreenView(
                context: context
            )

        } dynamicIsland: { context in

            DynamicIsland {

                // MARK: Expanded Leading

                DynamicIslandExpandedRegion(.leading) {

                    Image(systemName: "ticket.fill")
                        .foregroundStyle(.orange)
                }

                // MARK: Expanded Trailing

                DynamicIslandExpandedRegion(.trailing) {

                    Text(context.state.discountText)
                        .font(.headline.bold())
                        .foregroundStyle(.green)
                }

                // MARK: Expanded Bottom

                DynamicIslandExpandedRegion(.bottom) {

                    VStack(alignment: .leading, spacing: 8) {

                        Text(context.state.merchantName)
                            .font(.headline)

                        Text(context.state.couponCode)
                            .font(.title3.monospaced())

                        HStack {

                            Label(
                                context.state.distance,
                                systemImage: "location.fill"
                            )

                            Spacer()

                            Text(
                                context.state.expiryDate,
                                style: .relative
                            )
                        }
                        .font(.caption)
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
}
