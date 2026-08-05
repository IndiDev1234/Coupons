//
//  CompactTrailingView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import SwiftUI

struct CompactTrailingView: View {

    let discount: String
    let status: CouponStatus

    private var color: Color {
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

    var body: some View {
        Text(discount)
            .font(.system(size: 11, weight: .bold))
            .foregroundStyle(color)
            .lineLimit(1)
    }
}
