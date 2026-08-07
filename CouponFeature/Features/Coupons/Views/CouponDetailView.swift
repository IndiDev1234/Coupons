//
//  CouponDetailView.swift
//  CouponFeature
//

import SwiftUI
import SwiftData
import MapKit

struct CouponDetailView: View {

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var viewModel: CouponDetailViewModel

    @State
    private var shareCoupon = false

    init(coupon: Coupon) {

        _viewModel = State(
            initialValue: CouponDetailViewModel(
                coupon: coupon
            )
        )
    }

    var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                CouponHeroCard(
                    coupon: viewModel.coupon
                )

                CouponCodeCard(
                    coupon: viewModel.coupon
                )

                CouponInfoCard(
                    coupon: viewModel.coupon
                )

                CouponActionBar(

                    coupon: viewModel.coupon,

                    onFavorite: {

                        do {

                            try viewModel.toggleFavorite(
                                using: modelContext
                            )

                        } catch {

                            print(error)
                        }
                    },

                    onRedeem: {

                        do {

                            try viewModel.toggleRedeemed(
                                using: modelContext
                            )

                        } catch {

                            print(error)
                        }
                    },

                    onNavigate: {

                        guard
                            let merchant = viewModel.coupon.merchant?.name
                        else {

                            return
                        }

                        let request = MKLocalSearch.Request()

                        request.naturalLanguageQuery = merchant

                        Task {

                            let response = try? await MKLocalSearch(
                                request: request
                            ).start()

                            response?
                                .mapItems
                                .first?
                                .openInMaps()
                        }
                    },

                    onShare: {

                        shareCoupon = true
                    },

                    onReminder: {

                        print("Reminder Coming Soon")
                    }
                )
            }
            .padding()
        }
        .navigationTitle("Coupon")
        .navigationBarTitleDisplayMode(.inline)

        .sheet(isPresented: $shareCoupon) {

            ShareLink(
                item: shareText
            ) {

                Text("Share Coupon")
            }
            .padding()
        }
    }
}

private extension CouponDetailView {

    var shareText: String {

        """
        \(viewModel.coupon.title)

        Merchant: \(viewModel.coupon.merchant?.name ?? "")

        Coupon Code:
        \(viewModel.coupon.couponCode ?? "")

        Sent from OnePass
        """
    }
}
