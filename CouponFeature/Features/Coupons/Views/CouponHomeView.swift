//
//  CouponHomeView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//

import SwiftUI
import SwiftData

struct CouponHomeView: View {

    @State private var showAddCoupon = false
    @State private var showAddOptions = false
    @State private var showScanner = false
    @State private var searchText = ""

    @State
    private var sortOption: CouponSortOption = .newest

    @Query(
        sort: \Coupon.createdAt,
        order: .reverse
    )
    private var coupons: [Coupon]

    private var displayedCoupons: [Coupon] {

        let searchedCoupons: [Coupon]

        if searchText.isEmpty {

            searchedCoupons = coupons

        } else {

            searchedCoupons = coupons.filter { coupon in

                let merchant = coupon.merchant?.name ?? ""

                return merchant.localizedCaseInsensitiveContains(searchText)
                    || coupon.title.localizedCaseInsensitiveContains(searchText)
                    || (coupon.couponCode ?? "")
                        .localizedCaseInsensitiveContains(searchText)
            }
        }

        switch sortOption {

        case .newest:

            return searchedCoupons.sorted {
                $0.createdAt > $1.createdAt
            }

        case .expiry:

            return searchedCoupons.sorted {
                ($0.expiryDate ?? .distantFuture)
                <
                ($1.expiryDate ?? .distantFuture)
            }

        case .merchant:

            return searchedCoupons.sorted {
                ($0.merchant?.name ?? "")
                <
                ($1.merchant?.name ?? "")
            }

        case .highestDiscount:

            return searchedCoupons.sorted {
                ($0.discountValue ?? 0)
                >
                ($1.discountValue ?? 0)
            }
        }
    }

    var body: some View {

        ScrollView {

            if displayedCoupons.isEmpty {

                if searchText.isEmpty {

                    EmptyStateView {

                        showAddOptions = true

                    }
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 450)

                } else {

                    ContentUnavailableView.search(
                        text: searchText
                    )
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 450)
                }

            } else {

                LazyVStack(spacing: 16) {

                    ForEach(displayedCoupons) { coupon in

                        NavigationLink {

                            CouponDetailView(
                                coupon: coupon
                            )

                        } label: {

                            CouponListCardView(
                                coupon: coupon
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
                .padding(.bottom, 100)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Coupons")
        .navigationBarTitleDisplayMode(.large)
        .searchable(
            text: $searchText,
            placement: .automatic,
            prompt: "Search Coupons"
        )
        .toolbar {

            ToolbarItemGroup(
                placement: .topBarTrailing
            ) {

                Menu {

                    Picker(
                        "Sort",
                        selection: $sortOption
                    ) {

                        ForEach(
                            CouponSortOption.allCases
                        ) { option in

                            Label(
                                option.title,
                                systemImage: option.systemImage
                            )
                            .tag(option)
                        }
                    }

                } label: {

                    Image(
                        systemName: "arrow.up.arrow.down.circle"
                    )
                }

                Button {

                    showAddOptions = true

                } label: {

                    Image(systemName: "plus")
                }
            }
        }

        // MARK: Add Options

        .sheet(isPresented: $showAddOptions) {

            AddCouponOptionsSheet(

                addManually: {

                    showAddOptions = false

                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + 0.25
                    ) {

                        showAddCoupon = true
                    }
                },

                scanCoupon: {

                    showAddOptions = false

                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + 0.25
                    ) {

                        showScanner = true
                    }
                }
            )
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }

        .sheet(isPresented: $showAddCoupon) {

            NavigationStack {

                AddCouponView()
            }
            .presentationDetents([
                .large
            ])
        }

        .sheet(isPresented: $showScanner) {

            NavigationStack {

                CouponScannerView()
            }
        }
    }
}

#Preview {

    NavigationStack {

        CouponHomeView()
    }
}
