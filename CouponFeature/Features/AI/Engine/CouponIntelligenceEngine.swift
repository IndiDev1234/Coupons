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

        guard (extraction.confidence ?? 0) >= Constants.minimumAIConfidence else {

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
            
            // We'll parse this in FoundationModelService later
            expiryDate:
                nil,
            
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
                []
        )
    }
}
