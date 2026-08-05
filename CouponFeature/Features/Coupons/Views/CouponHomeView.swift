//
//  CouponHomeView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//

import SwiftUI

struct CouponHomeView: View {

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                Button("Start Live Activity") {

                    Task {

                        await LiveActivityManager.shared.startMockCoupon()

                    }
                }

                .buttonStyle(.borderedProminent)

                Button("Update Live Activity") {

                    Task {

                        await LiveActivityManager.shared.updateCoupon()

                    }
                }

                .buttonStyle(.bordered)

                Button("End Live Activity") {

                    Task {

                        await LiveActivityManager.shared.endCoupon()

                    }
                }

                .buttonStyle(.bordered)

            }

            .navigationTitle("Coupons")
        }
    }
}

#Preview {

    CouponHomeView()

}
