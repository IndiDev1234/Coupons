//
//  CouponIntelligenceEngine.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation

protocol CouponIntelligenceEngineProtocol {

    func extractCoupon(
        from scanResult: CouponScanResult
    ) async throws -> CouponDraft
}

final class CouponIntelligenceEngine: CouponIntelligenceEngineProtocol {

    // MARK: Dependencies

    private let foundationService: FoundationModelServiceProtocol
    private let regexParser: CouponParserProtocol

    // MARK: Initializer

    init(
        foundationService: FoundationModelServiceProtocol = FoundationModelService(),
        regexParser: CouponParserProtocol = CouponParser()
    ) {
        self.foundationService = foundationService
        self.regexParser = regexParser
    }

    // MARK: Public

    func extractCoupon(
        from scanResult: CouponScanResult
    ) async throws -> CouponDraft {

        let extraction = try await foundationService.extractCoupon(
            from: scanResult
        )

        // Fallback to regex parser when AI confidence is low
        guard (extraction.confidence ?? 0) >= 0.75 else {

            return regexParser.parse(
                from: scanResult
            )
        }

        return convert(extraction)
    }
}

// MARK: - Private Helpers

private extension CouponIntelligenceEngine {

    func convert(
        _ extraction: CouponExtraction
    ) -> CouponDraft {

        CouponDraft(

            title:
                extraction.title
                ?? extraction.merchant
                ?? "Scanned Coupon",

            couponCode:
                extraction.couponCode ?? "",

            discountValue:
                extraction.discountValue,

            discountType:
                mapDiscountType(
                    extraction.discountType
                ),

            minimumPurchase:
                extraction.minimumPurchase,

            expiryDate:
                nil, // Will be parsed inside FoundationModelService

            merchantName:
                extraction.merchant ?? "",

            storeName:
                "",

            termsAndConditions:
                extraction.termsSummary ?? "",

            notes:
                "",

            attachments:
                []
        )
    }

    func mapDiscountType(
        _ value: String?
    ) -> DiscountType {

        guard let value else {

            return .percentage
        }

        switch value.lowercased() {

        case "percentage":

            return .percentage

        case "fixedamount",
             "fixed amount":

            return .fixedAmount

        case "freeitem",
             "free item":

            return .freeItem

        default:

            return .percentage
        }
    }
}
