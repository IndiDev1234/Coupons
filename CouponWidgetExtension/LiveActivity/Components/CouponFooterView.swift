//
//  CouponFooterView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//

import SwiftUI

struct CouponFooterView: View {

    let distance: String
    let expiryDate: Date

    var body: some View {

        HStack(alignment: .center) {

            Label {
                Text(distance)
                    .font(.caption.bold())
            } icon: {
                Image(systemName: ActivityIcons.location)
                    .font(.caption)
                    .foregroundStyle(.blue)
            }

            Spacer()

            CountdownView(
                expiryDate: expiryDate
            )
        }
        .foregroundStyle(ActivityColors.secondaryText)
    }
}
