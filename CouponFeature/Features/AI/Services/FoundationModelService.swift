//
//  FoundationModelService.swift
//  CouponFeature
//

import Foundation
import FoundationModels

final class FoundationModelService: FoundationModelServiceProtocol {

    // MARK: Session

    private let session = LanguageModelSession(
        instructions: """
        You are an expert coupon extraction assistant.

        Extract coupon information accurately.

        Never invent values.

        If a value is missing return nil.
        """
    )

    // MARK: Public

    func extractCoupon(
        from scanResult: CouponScanResult
    ) async throws -> CouponExtraction {

        guard SystemLanguageModel.default.isAvailable else {
            throw AIError.modelUnavailable
        }

        let ocrText = scanResult.recognizedTexts
            .map(\.text)
            .joined(separator: "\n")

        guard !ocrText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty else {

            throw AIError.emptyOCR
        }

        let prompt = CouponPromptBuilder
            .extractionPrompt(from: ocrText)

        let response = try await session.respond(
            to: prompt,
            generating: CouponExtraction.self
        )

        return response.content
    }
}
