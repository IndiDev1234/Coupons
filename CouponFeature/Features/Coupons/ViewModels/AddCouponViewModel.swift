//
//  AddCouponViewModel.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import Observation
import SwiftData

@Observable
final class AddCouponViewModel {

    // MARK: - Merchant

    var merchantName = ""
    var storeName = ""
    var merchantCategory: MerchantCategory = .other

    // MARK: - Coupon

    var couponTitle = ""
    var couponCode = ""

    // MARK: - Discount

    var discountValue = ""
    var discountType: DiscountType = .percentage
    var minimumPurchase = ""

    // MARK: - Expiry

    var expiryDate = Date()

    // MARK: - Notes

    var notes = ""

    // MARK: - Validation

    var canSave: Bool {

        !merchantName
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty
        &&
        !couponTitle
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty
    }

    // MARK: - Load Existing Coupon

    func load(from coupon: Coupon) {

        merchantName = coupon.merchant?.name ?? ""
        merchantCategory = coupon.merchant?.category ?? .other

        couponTitle = coupon.title
        couponCode = coupon.couponCode ?? ""

        if let value = coupon.discountValue {
            discountValue = String(value)
        } else {
            discountValue = ""
        }

        discountType = coupon.discountType

        if let minimum = coupon.minimumPurchase {
            minimumPurchase = String(minimum)
        } else {
            minimumPurchase = ""
        }

        expiryDate = coupon.expiryDate ?? .now

        notes = coupon.notes ?? ""
    }

    // MARK: - Save

    @MainActor
    func save(
        mode: CouponFormMode,
        coupon: Coupon?,
        using modelContext: ModelContext
    ) throws {

        guard canSave else {
            return
        }

        let merchant = try fetchOrCreateMerchant(
            using: modelContext
        )

        switch mode {

        case .create:

            try createCoupon(
                merchant: merchant,
                using: modelContext
            )

        case .edit:

            guard let coupon else {
                return
            }

            try updateCoupon(
                coupon,
                merchant: merchant
            )
        }

        try modelContext.save()
    }
}

// MARK: - Private Helpers

private extension AddCouponViewModel {

    func fetchOrCreateMerchant(
        using context: ModelContext
    ) throws -> Merchant {

        let descriptor = FetchDescriptor<Merchant>(
            predicate: #Predicate {
                $0.name == merchantName
            }
        )

        if let merchant = try context.fetch(descriptor).first {

            merchant.category = merchantCategory

            return merchant
        }

        let merchant = Merchant(
            name: merchantName,
            category: merchantCategory
        )

        context.insert(merchant)

        return merchant
    }

    func createCoupon(
        merchant: Merchant,
        using context: ModelContext
    ) throws {

        let coupon = Coupon(
            title: couponTitle,
            couponCode: couponCode.nilIfEmpty,
            discountValue: Double(discountValue),
            discountType: discountType,
            minimumPurchase: Double(minimumPurchase),
            expiryDate: expiryDate,
            termsAndConditions: nil,
            notes: notes.nilIfEmpty
        )

        coupon.merchant = merchant

        context.insert(coupon)
    }

    func updateCoupon(
        _ coupon: Coupon,
        merchant: Merchant
    ) throws {

        coupon.title = couponTitle
        coupon.couponCode = couponCode.nilIfEmpty
        coupon.discountValue = Double(discountValue)
        coupon.discountType = discountType
        coupon.minimumPurchase = Double(minimumPurchase)
        coupon.expiryDate = expiryDate
        coupon.notes = notes.nilIfEmpty
        coupon.updatedAt = .now
        coupon.merchant = merchant
    }
}

// MARK: - String Helpers

private extension String {

    var nilIfEmpty: String? {

        let trimmed = trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        return trimmed.isEmpty ? nil : trimmed
    }
}
