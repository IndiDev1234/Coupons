//
//  CouponRepository.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import Foundation
import SwiftData

@MainActor
final class CouponRepository: CouponRepositoryProtocol {

    // MARK: - Properties

    private let modelContext: ModelContext

    // MARK: - Initializer

    init(
        modelContext: ModelContext
    ) {
        self.modelContext = modelContext
    }

    // MARK: - Coupon

    func fetchAll() throws -> [Coupon] {

        let descriptor = FetchDescriptor<Coupon>(
            sortBy: [
                SortDescriptor(\.createdAt, order: .reverse)
            ]
        )

        return try modelContext.fetch(
            descriptor
        )
    }

    func fetch(
        by id: UUID
    ) throws -> Coupon? {

        let descriptor = FetchDescriptor<Coupon>(
            predicate: #Predicate<Coupon> {
                $0.id == id
            }
        )

        return try modelContext.fetch(
            descriptor
        ).first
    }

    func fetchCouponsForDuplicateCheck() throws -> [Coupon] {

        try modelContext.fetch(
            FetchDescriptor<Coupon>()
        )
    }

    // MARK: - Merchant

    func fetchMerchant(
        named name: String
    ) throws -> Merchant? {

        let descriptor = FetchDescriptor<Merchant>(
            predicate: #Predicate<Merchant> {
                $0.name == name
            }
        )

        return try modelContext.fetch(
            descriptor
        ).first
    }

    // MARK: - Insert

    func insert(
        _ coupon: Coupon
    ) {

        modelContext.insert(
            coupon
        )
    }

    func insert(
        _ merchant: Merchant
    ) {

        modelContext.insert(
            merchant
        )
    }

    // MARK: - Delete

    func delete(
        _ coupon: Coupon
    ) {

        modelContext.delete(
            coupon
        )
    }

    // MARK: - Save

    func save() throws {

        try modelContext.save()
    }
}
