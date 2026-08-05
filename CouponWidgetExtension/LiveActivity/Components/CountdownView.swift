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

    var body: some View {

        HStack(spacing: ActivitySpacing.xxSmall) {

            Image(systemName: ActivityIcons.clock)

            Text(expiryDate, style: .relative)
        }
        .foregroundStyle(countdownColor)
        .font(ActivityFonts.caption)
    }
}
