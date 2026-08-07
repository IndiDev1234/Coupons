//
//  CouponHomeView.swift
//  CouponFeature
//

import SwiftUI
import SwiftData

struct CouponHomeView: View {

    // MARK: State

    @State private var showAddCoupon = false
    @State private var showAddOptions = false
    @State private var showScanner = false

    @State private var searchText = ""
    @State private var selectedFilter: CouponFilter = .all
    @State private var sortOption: CouponSortOption = .newest

    // MARK: Data

    @Query(
        sort: \Coupon.createdAt,
        order: .reverse
    )
    private var coupons: [Coupon]

    private let searchEngine = CouponSearchEngine()

    private var displayedCoupons: [Coupon] {

        searchEngine.search(
            coupons: coupons,
            text: searchText,
            filter: selectedFilter,
            sort: sortOption
        )
    }

    // MARK: Body

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

                            CouponPreviewCard(
                                configuration: CouponPreviewConfiguration(
                                    merchant: coupon.merchant?.name ?? "",
                                    title: coupon.title,
                                    couponCode: coupon.couponCode ?? "",
                                    discountValue: coupon.discountValue,
                                    discountType: coupon.discountType,
                                    expiryDate: coupon.expiryDate,
                                    isFavorite: coupon.isFavorite,
                                    isRedeemed: coupon.isRedeemed,
                                    aiConfidence: nil
                                )
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

        .safeAreaInset(edge: .top) {

            CouponFilterBar(
                selectedFilter: $selectedFilter
            )
            .padding(.vertical, 8)
            .background(.bar)
        }

        .toolbar {

            ToolbarItemGroup(
                placement: .topBarTrailing
            ) {

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
            .presentationDetents([.large])
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
