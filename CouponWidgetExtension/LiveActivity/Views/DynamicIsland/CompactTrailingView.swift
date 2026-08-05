//
//  CompactTrailingView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import SwiftUI

struct CompactTrailingView: View {

    let discount: String

    var body: some View {

        Text(discount)
            .font(.caption2.bold())
            .foregroundStyle(ActivityColors.success)
            .lineLimit(1)
    }
}
