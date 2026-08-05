//
//  CountdownView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//

import SwiftUI

struct CountdownView: View {

    let expiryDate: Date

    private var isExpired: Bool {
        expiryDate < .now
    }

    private var expiresToday: Bool {
        Calendar.current.isDateInToday(expiryDate)
    }

    private var countdownColor: Color {
        if isExpired {
            return ActivityColors.error
        }
        if expiresToday {
            return ActivityColors.warning
        }
        return ActivityColors.success
    }

    private var backgroundColor: Color {
        countdownColor.opacity(0.12)
    }

    var body: some View {
        HStack(spacing: ActivitySpacing.xxSmall) {
            Image(systemName: ActivityIcons.clock)
                .font(.caption2)

            Text(expiryDate, style: .relative)
                .font(.caption.bold())
        }
        .foregroundStyle(countdownColor)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(backgroundColor)
        )
        .overlay(
            Capsule()
                .strokeBorder(countdownColor.opacity(0.25), lineWidth: 1)
        )
    }
}
