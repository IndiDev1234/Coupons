//
//  CouponRepositoryProtocol.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import Foundation

@MainActor
protocol CouponRepositoryProtocol {

    func fetchAll() throws -> [Coupon]

    func fetch(by id: UUID) throws -> Coupon?

    func fetchMerchant(
        named name: String
    ) throws -> Merchant?

    func fetchCouponsForDuplicateCheck() throws -> [Coupon]

    func insert(
        _ coupon: Coupon
    )

    func insert(
        _ merchant: Merchant
    )

    func delete(
        _ coupon: Coupon
    )

    func save() throws
}
