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
    @State private var searchText = ""
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
    @State private var sortOption: CouponSortOption = .newest
    
    var body: some View {

        ScrollView {

            VStack(spacing: 0) {

                // MARK: Header

                HStack {

                    Text("Coupons")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Spacer()

                    HStack(spacing: 12) {

                        Menu {

                            Picker(
                                "Sort",
                                selection: $sortOption
                            ) {

                                ForEach(CouponSortOption.allCases) { option in

                                    Label(
                                        option.title,
                                        systemImage: option.systemImage
                                    )
                                    .tag(option)
                                }
                            }

                        } label: {

                            Image(systemName: "arrow.up.arrow.down.circle")
                                .font(.title3.weight(.semibold))
                                .frame(width: 44, height: 44)
                        }
                        .buttonStyle(.glass)

                        Button {

                            showAddCoupon = true

                        } label: {

                            Image(systemName: "plus")
                                .font(.title3.weight(.semibold))
                                .frame(width: 44, height: 44)
                        }
                        .buttonStyle(.glass)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)

                Spacer(minLength: 60)

                // MARK: Empty State

                if displayedCoupons.isEmpty {

                    if searchText.isEmpty {

                        EmptyStateView {

                            showAddCoupon = true
                        }

                    } else {

                        ContentUnavailableView.search(
                            text: searchText
                        )
                    }

                }  else {

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
                }

                Spacer(minLength: 80)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: UIScreen.main.bounds.height - 180)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarBackButtonHidden()
        .searchable(
            text: $searchText,
            placement: .automatic,
            prompt: "Search Coupons"
        )
        .sheet(isPresented: $showAddCoupon) {

            NavigationStack {

                AddCouponView()
            }
            .presentationDetents([
                .large
            ])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {

    NavigationStack {

        CouponHomeView()
    }
}
