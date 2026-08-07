//
//  CouponBackground.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

//
//  CouponBackground.swift
//  OnePass
//

import SwiftUI

struct CouponBackground: View {

    var body: some View {

        RoundedRectangle(
            cornerRadius: 28,
            style: .continuous
        )
        .fill(
            LinearGradient(

                colors: [

                    Color(
                        red: 0.96,
                        green: 0.98,
                        blue: 1.0
                    ),

                    Color.white
                ],

                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .overlay {

            RoundedRectangle(
                cornerRadius: 28,
                style: .continuous
            )
            .strokeBorder(
                Color.primary.opacity(0.08),
                lineWidth: 1
            )
        }
        .shadow(
            color: .black.opacity(0.08),
            radius: 18,
            y: 10
        )
    }
}

#Preview {

    CouponBackground()
        .frame(height: 220)
        .padding()
}
