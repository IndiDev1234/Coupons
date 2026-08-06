//
//  CouponScannerService.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import UIKit
import Vision

protocol CouponScannerServiceProtocol {

    func recognizeText(
        from image: UIImage
    ) async throws -> CouponScanResult
}

final class CouponScannerService: CouponScannerServiceProtocol {

    func recognizeText(
        from image: UIImage
    ) async throws -> CouponScanResult {

        guard let cgImage = image.cgImage else {
            throw CouponScanError.imageNotFound
        }

        return try await withCheckedThrowingContinuation { continuation in

            let request = VNRecognizeTextRequest { request, error in

                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let observations = request.results as? [VNRecognizedTextObservation] else {

                    continuation.resume(
                        throwing: CouponScanError.textRecognitionFailed
                    )

                    return
                }

                let recognizedTexts: [RecognizedText] = observations.compactMap {

                    observation in

                    guard let candidate = observation.topCandidates(1).first else {
                        return nil
                    }

                    return RecognizedText(
                        text: candidate.string,
                        confidence: candidate.confidence,
                        boundingBox: observation.boundingBox
                    )
                }

                let result = CouponScanResult(
                    recognizedTexts: recognizedTexts
                )

                continuation.resume(returning: result)
            }

            // MARK: OCR Configuration

            request.recognitionLevel = .accurate
            request.usesLanguageCorrection = true
            request.recognitionLanguages = [
                OCRLanguage.english.rawValue
            ]

            request.minimumTextHeight = 0.015

            let handler = VNImageRequestHandler(
                cgImage: cgImage,
                options: [:]
            )

            do {

                try handler.perform([request])

            } catch {

                continuation.resume(
                    throwing: error
                )
            }
        }
    }
}
