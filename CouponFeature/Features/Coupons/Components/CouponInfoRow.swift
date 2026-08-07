//
//  CouponInfoRow.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


//
//  CouponInfoRow.swift
//  CouponFeature
//

import SwiftUI

struct CouponInfoRow: View {

    let title: String

    let value: String

    var body: some View {

        HStack {

            Text(title)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .fontWeight(.medium)
                .multilineTextAlignment(.trailing)
        }
    }
}