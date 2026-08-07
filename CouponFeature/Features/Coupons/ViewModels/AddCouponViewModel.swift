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
    ) throws -> Coupon {

        guard canSave else {
            throw CouponSaveError.invalidForm
        }

        let merchant = try fetchOrCreateMerchant(
            using: modelContext
        )

        let savedCoupon: Coupon

        switch mode {

        case .create:

            savedCoupon = try createCoupon(
                merchant: merchant,
                using: modelContext
            )

        case .edit:

            guard let coupon else {

                throw CouponSaveError.missingCouponForEdit
            }

            savedCoupon = try updateCoupon(
                coupon,
                merchant: merchant
            )
        }

        try modelContext.save()

        return savedCoupon

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
    ) throws -> Coupon {
        print("🔵 Saving Discount String:", discountValue)

        let parsedDiscount = Double(
            discountValue
                .replacingOccurrences(of: "%", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
        )

        print("🔵 Parsed Discount:", parsedDiscount as Any)
        let coupon = Coupon(
            title: couponTitle,
            couponCode: couponCode.nilIfEmpty,
//            discountValue: Double(discountValue),
            discountValue: parsedDiscount,
            discountType: discountType,
            minimumPurchase: Double(minimumPurchase),
            expiryDate: expiryDate,
            termsAndConditions: nil,
            notes: notes.nilIfEmpty
        )

        coupon.merchant = merchant

        context.insert(coupon)
        print("🟣 Coupon Model Discount:", coupon.discountValue as Any)
        return coupon
    }

    func updateCoupon(
        _ coupon: Coupon,
        merchant: Merchant
    ) throws -> Coupon {

        coupon.title = couponTitle
        coupon.couponCode = couponCode.nilIfEmpty
        coupon.discountValue = Double(discountValue)
        coupon.discountType = discountType
        coupon.minimumPurchase = Double(minimumPurchase)
        coupon.expiryDate = expiryDate
        coupon.notes = notes.nilIfEmpty
        coupon.updatedAt = .now
        coupon.merchant = merchant
        
        return coupon
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
