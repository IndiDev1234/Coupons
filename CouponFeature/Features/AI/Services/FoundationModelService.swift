//
//  FoundationModelService.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation
import FoundationModels

final class FoundationModelService: FoundationModelServiceProtocol {

    // MARK: - Session

    private let session = LanguageModelSession(
        instructions: """
        You are an expert coupon extraction assistant.

        Extract coupon information accurately.

        Never invent values.

        Return nil for missing information.

        Correct OCR mistakes only when you are highly confident.
        """
    )

    // MARK: - Public

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

        let prompt = CouponPromptBuilder.extractionPrompt(
            from: ocrText
        )

        return try await generateCouponExtraction(
            from: prompt
        )
    }
}

// MARK: - Private Helpers

private extension FoundationModelService {

    func generateCouponExtraction(
        from prompt: String
    ) async throws -> CouponExtraction {

        let response = try await session.respond(
            to: prompt,
            generating: CouponExtraction.self
        )

        return response.content
    }
}
