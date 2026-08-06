//
//  CouponValidator.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation

struct CouponValidator: CouponValidatorProtocol {

    func validate(
        _ extraction: CouponExtraction
    ) throws {

        try validateConfidence(extraction)

        try validateMerchant(extraction)

        try validateDiscount(extraction)

        try validateMinimumPurchase(extraction)

        try validateExpiry(extraction)
    }
}

// MARK: - Private Helpers

private extension CouponValidator {

    func validateConfidence(
        _ extraction: CouponExtraction
    ) throws {

        guard (extraction.confidence ?? 0) >= 0.75 else {
            throw AIValidationError.confidenceTooLow
        }
    }

    func validateMerchant(
        _ extraction: CouponExtraction
    ) throws {

        guard
            let merchant = extraction.merchant,
            !merchant.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            throw AIValidationError.merchantMissing
        }
    }

    func validateDiscount(
        _ extraction: CouponExtraction
    ) throws {

        guard let value = extraction.discountValue else {
            return
        }

        guard value >= 0 else {
            throw AIValidationError.invalidDiscount
        }

        if extraction.discountType?.lowercased() == "percentage",
           value > 100 {

            throw AIValidationError.invalidDiscount
        }
    }

    func validateMinimumPurchase(
        _ extraction: CouponExtraction
    ) throws {

        guard let minimum = extraction.minimumPurchase else {
            return
        }

        guard minimum >= 0 else {
            throw AIValidationError.invalidMinimumPurchase
        }
    }

    func validateExpiry(
        _ extraction: CouponExtraction
    ) throws {

        guard let expiry = extraction.expiryDate else {
            return
        }

        guard parseDate(expiry) != nil else {
            throw AIValidationError.invalidExpiry
        }
    }

    func parseDate(
        _ value: String
    ) -> Date? {

        let formatter = ISO8601DateFormatter()

        if let date = formatter.date(from: value) {
            return date
        }

        let dateFormatter = DateFormatter()

        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        let formats = [
            "yyyy-MM-dd",
            "dd/MM/yyyy",
            "dd-MM-yyyy",
            "dd MMM yyyy",
            "dd MMM yy",
            "MMM dd, yyyy"
        ]

        for format in formats {

            dateFormatter.dateFormat = format

            if let date = dateFormatter.date(from: value) {
                return date
            }
        }

        return nil
    }
}
