//
//  CouponListViewModel.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


import Foundation
import Observation

@Observable
@MainActor
final class CouponListViewModel {

    // MARK: Search

    var searchText = ""

    // MARK: Filter

    var selectedFilter: CouponFilter = .all

    // MARK: Sort

    var selectedSort: CouponSortOption = .newest

    // MARK: UI

    var isSearching = false

    // MARK: Search Engine

    private let searchEngine = CouponSearchEngine()

    func displayedCoupons(
        from coupons: [Coupon]
    ) -> [Coupon] {

        searchEngine.search(
            coupons: coupons,
            text: searchText,
            filter: selectedFilter,
            sort: selectedSort
        )
    }
}
