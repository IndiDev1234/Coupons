//
//  CouponParser.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import Foundation

protocol CouponParserProtocol {

    func parse(
        from result: CouponScanResult
    ) -> CouponDraft
}

final class CouponParser: CouponParserProtocol {

    func parse(
        from result: CouponScanResult
    ) -> CouponDraft {

        let lines = result.recognizedTexts
            .map(\.text)
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

        let merchant = extractMerchant(from: lines)
        let couponCode = extractCouponCode(from: lines)
        let discount = extractDiscount(from: lines)
        let expiry = extractExpiry(from: lines)

        return CouponDraft(
            title: merchant ?? "Scanned Coupon",
            couponCode: couponCode ?? "",
            discountValue: discount.value,
            discountType: discount.type,
            minimumPurchase: nil,
            expiryDate: expiry,
            merchantName: merchant ?? "",
            storeName: "",
            termsAndConditions: "",
            notes: lines.joined(separator: "\n"),
            attachments: []
        )
    }
}

// MARK: - Helpers

private extension CouponParser {

    func extractMerchant(
        from lines: [String]
    ) -> String? {

        guard let first = lines.first else {
            return nil
        }

        return first
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func extractCouponCode(
        from lines: [String]
    ) -> String? {

        let pattern = #"\b[A-Z0-9]{5,20}\b"#

        for line in lines {

            if let range = line.range(
                of: pattern,
                options: .regularExpression
            ) {

                return String(line[range])
            }
        }

        return nil
    }

    func extractDiscount(
        from lines: [String]
    ) -> (
        value: Double?,
        type: DiscountType
    ) {

        for line in lines {

            // Percentage

            if let match = line.range(
                of: #"\d{1,3}%"#,
                options: .regularExpression
            ) {

                let number = line[match]
                    .replacing("%", with: "")

                return (
                    Double(number),
                    .percentage
                )
            }

            // Fixed Amount

            if let match = line.range(
                of: #"₹\s?\d+"#,
                options: .regularExpression
            ) {

                let value = line[match]
                    .replacing("₹", with: "")
                    .trimmingCharacters(in: .whitespaces)

                return (
                    Double(value),
                    .fixedAmount
                )
            }

            // Free Item

            if line.localizedCaseInsensitiveContains("free")
                || line.localizedCaseInsensitiveContains("buy 1 get 1")
                || line.localizedCaseInsensitiveContains("bogo") {

                return (
                    nil,
                    .freeItem
                )
            }
        }

        return (
            nil,
            .percentage
        )
    }

    func extractExpiry(
        from lines: [String]
    ) -> Date? {

        let formatter = DateFormatter()

        formatter.locale = Locale(identifier: "en_US_POSIX")

        let formats = [

            "dd MMM yyyy",
            "dd MMM yy",
            "dd/MM/yyyy",
            "dd-MM-yyyy",
            "yyyy-MM-dd"
        ]

        for line in lines {

            for format in formats {

                formatter.dateFormat = format

                if let date = formatter.date(
                    from: line
                ) {

                    return date
                }
            }
        }

        return nil
    }
}
