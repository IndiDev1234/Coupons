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

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func fetchAll() throws -> [Coupon] {

        let descriptor = FetchDescriptor<Coupon>(
            sortBy: [
                SortDescriptor(\.createdAt, order: .reverse)
            ]
        )

        return try modelContext.fetch(descriptor)
    }

    func fetch(by id: UUID) throws -> Coupon? {

        let descriptor = FetchDescriptor<Coupon>(
            predicate: #Predicate {
                $0.id == id
            }
        )

        return try modelContext.fetch(descriptor).first
    }

    func insert(_ coupon: Coupon) throws {

        modelContext.insert(coupon)

        try modelContext.save()
    }

    func update() throws {

        try modelContext.save()
    }

    func delete(_ coupon: Coupon) throws {

        modelContext.delete(coupon)

        try modelContext.save()
    }
}
