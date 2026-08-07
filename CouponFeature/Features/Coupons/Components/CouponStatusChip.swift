//
//  CouponStatusChip.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


import SwiftUI

struct CouponStatusChip: View {

    let expiryDate: Date?
    let isRedeemed: Bool

    private enum Status {

        case active
        case today
        case expired
        case redeemed
    }

    private var status: Status {

        if isRedeemed {
            return .redeemed
        }

        guard let expiryDate else {
            return .active
        }

        let calendar = Calendar.current

        if calendar.isDateInToday(expiryDate) {
            return .today
        }

        if expiryDate < Date() {
            return .expired
        }

        return .active
    }

    private var title: String {

        switch status {

        case .active:
            return "ACTIVE"

        case .today:
            return "TODAY"

        case .expired:
            return "EXPIRED"

        case .redeemed:
            return "USED"
        }
    }

    private var color: Color {

        switch status {

        case .active:
            return .green

        case .today:
            return .orange

        case .expired:
            return .red

        case .redeemed:
            return .gray
        }
    }

    var body: some View {

        Text(title)
            .font(.caption.weight(.bold))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(color.opacity(0.15))
            )
            .foregroundStyle(color)
    }
}

#Preview {

    VStack(spacing: 20) {

        CouponStatusChip(
            expiryDate: .now.addingTimeInterval(86400 * 5),
            isRedeemed: false
        )

        CouponStatusChip(
            expiryDate: .now,
            isRedeemed: false
        )

        CouponStatusChip(
            expiryDate: .now.addingTimeInterval(-86400),
            isRedeemed: false
        )

        CouponStatusChip(
            expiryDate: .now.addingTimeInterval(86400),
            isRedeemed: true
        )
    }
    .padding()
}
