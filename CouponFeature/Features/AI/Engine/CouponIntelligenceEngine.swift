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

    // MARK: - Dependencies

    private let foundationService: FoundationModelServiceProtocol
    private let regexParser: CouponParserProtocol
    private let merchantResolver: MerchantResolverProtocol
    private let validator: CouponValidatorProtocol

    // MARK: - Constants

    private enum Constants {

        static let minimumAIConfidence = 0.75
    }

    // MARK: - Initializer

    init(
        foundationService: FoundationModelServiceProtocol = FoundationModelService(),
        regexParser: CouponParserProtocol = CouponParser(),
        merchantResolver: MerchantResolverProtocol = MerchantResolver(),
        validator: CouponValidatorProtocol = CouponValidator()
    ) {

        self.foundationService = foundationService
        self.regexParser = regexParser
        self.merchantResolver = merchantResolver
        self.validator = validator
    }

    // MARK: - Public

    func extractCoupon(
        from scanResult: CouponScanResult
    ) async throws -> CouponDraft {

        let extraction = try await foundationService.extractCoupon(
            from: scanResult
        )

        // Validate AI response
        try validator.validate(
            extraction
        )

        // Low confidence → Regex fallback
        guard (extraction.confidence ?? 0) >= Constants.minimumAIConfidence else {

            var draft = regexParser.parse(
                from: scanResult
            )

            draft.aiConfidence = extraction.confidence

            return draft
        }

        return convert(
            extraction
        )
    }
}

// MARK: - Private Helpers

private extension CouponIntelligenceEngine {

    func convert(
        _ extraction: CouponExtraction
    ) -> CouponDraft {

        let merchantMatch = merchantResolver.resolve(
            from: extraction.merchant ?? ""
        )

        return CouponDraft(

            title:
                extraction.title
                ?? merchantMatch?.name
                ?? extraction.merchant
                ?? "Scanned Coupon",

            couponCode:
                extraction.couponCode ?? "",

            discountValue:
                extraction.discountValue,

            discountType:
                .fromAI(
                    extraction.discountType
                ),

            minimumPurchase:
                extraction.minimumPurchase,

            expiryDate:
                parseDate(
                    extraction.expiryDate
                ),

            merchantName:
                merchantMatch?.name
                ?? extraction.merchant
                ?? "",

            storeName:
                "",

            termsAndConditions:
                extraction.termsSummary ?? "",

            notes:
                "",

            attachments:
                [],

            aiConfidence:
                extraction.confidence
        )
    }

    func parseDate(
        _ string: String?
    ) -> Date? {

        guard let string,
              !string.isEmpty else {

            return nil
        }

        let isoFormatter = ISO8601DateFormatter()

        if let date = isoFormatter.date(
            from: string
        ) {

            return date
        }

        let formatter = DateFormatter()

        formatter.locale = Locale(
            identifier: "en_US_POSIX"
        )

        let formats = [

            "yyyy-MM-dd",
            "dd/MM/yyyy",
            "dd-MM-yyyy",
            "dd MMM yyyy",
            "dd MMM yy",
            "MMM dd, yyyy"
        ]

        for format in formats {

            formatter.dateFormat = format

            if let date = formatter.date(
                from: string
            ) {

                return date
            }
        }

        return nil
    }
}
