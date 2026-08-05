//
//  CouponDynamicIslandView.swift
//  CouponWidgetExtension
//
//  Created by Vansh Sharma on 05/08/26.
//

import SwiftUI
import WidgetKit
import ActivityKit

enum CouponDynamicIslandBuilder {

    private static func getAvatarGradient(for status: CouponStatus) -> LinearGradient {
        switch status {
        case .active:
            return ActivityColors.successGradient
        case .expiringSoon:
            return ActivityColors.warningGradient
        case .expired:
            return ActivityColors.errorGradient
        case .redeemed:
            return ActivityColors.redeemedGradient
        }
    }

    private static func getKeylineTint(for status: CouponStatus) -> Color {
        switch status {
        case .active:
            return ActivityColors.success
        case .expiringSoon:
            return ActivityColors.warning
        case .expired:
            return ActivityColors.error
        case .redeemed:
            return .gray
        }
    }

    static func make(
        context: ActivityViewContext<CouponActivityAttributes>
    ) -> DynamicIsland {

        DynamicIsland {

            // MARK: Expanded Leading
            DynamicIslandExpandedRegion(.leading) {
                Text(String(context.state.merchantName.prefix(1)).uppercased())
                    .font(.subheadline.bold())
                    .foregroundStyle(.white)
                    .frame(width: 32, height: 32)
                    .background(
                        Circle()
                            .fill(getAvatarGradient(for: context.state.status))
                    )
                    .overlay(
                        Circle()
                            .strokeBorder(.white.opacity(0.15), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                    .padding(.top, 4)
            }

            // MARK: Expanded Trailing
            // Display only the discount text in a compact capsule to prevent truncation
            DynamicIslandExpandedRegion(.trailing) {
                Text(context.state.discountText)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(ActivityColors.successGradient)
                    )
                    .overlay(
                        Capsule()
                            .strokeBorder(.white.opacity(0.15), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 0.5)
                    .padding(.top, 4)
            }

            // MARK: Expanded Center
            // Status badge is placed next to the merchant name to enjoy full width and avoid truncation
            DynamicIslandExpandedRegion(.center) {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(alignment: .center, spacing: ActivitySpacing.xxSmall) {
                        Text(context.state.merchantName)
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(ActivityColors.primaryText)
                            .lineLimit(1)

                        CouponStatusBadgeView(status: context.state.status)
                    }

                    Text(context.state.couponTitle)
                        .font(.subheadline)
                        .foregroundStyle(ActivityColors.secondaryText)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            // MARK: Expanded Bottom
            DynamicIslandExpandedRegion(.bottom) {
                HStack(alignment: .center, spacing: ActivitySpacing.small) {
                    // Slim code pill for Dynamic Island integration with liquid glass styling
                    HStack(spacing: 6) {
                        Image(systemName: "barcode.viewfinder")
                            .font(.footnote)
                            .foregroundStyle(ActivityColors.accent)

                        Text(context.state.couponCode)
                            .font(.system(size: 13, weight: .bold, design: .monospaced))
                            .foregroundStyle(ActivityColors.primaryText)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.ultraThinMaterial)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [.white.opacity(0.2), .clear, .white.opacity(0.05)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )

                    Spacer()

                    // Proximity details
                    HStack(spacing: 4) {
                        Image(systemName: ActivityIcons.location)
                            .font(.caption2)
                            .foregroundStyle(.blue)

                        Text(context.state.distance)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(ActivityColors.secondaryText)
                    }

                    // Expiry countdown pill
                    CountdownView(
                        expiryDate: context.state.expiryDate
                    )
                }
                .padding(.top, 4)
            }

        } compactLeading: {

            CompactLeadingView(status: context.state.status)

        } compactTrailing: {

            CompactTrailingView(
                discount: context.state.discountText,
                status: context.state.status
            )

        } minimal: {

            MinimalView(status: context.state.status)
        }
        .keylineTint(getKeylineTint(for: context.state.status))
    }
}
