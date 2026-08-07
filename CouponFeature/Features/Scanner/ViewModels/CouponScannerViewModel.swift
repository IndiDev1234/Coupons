//
//  CouponScannerViewModel.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import UIKit
import Observation
import OSLog

@Observable
@MainActor
final class CouponScannerViewModel {

    // MARK: - Dependencies

    private let processor: ImageProcessorProtocol
    private let scanner: CouponScannerServiceProtocol
    private let intelligenceEngine: CouponIntelligenceEngineProtocol

    // MARK: - Logger

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "CouponFeature",
        category: "CouponScanner"
    )

    // MARK: - UI State

    var isScanning = false

    var draft: CouponDraft?

    var errorMessage: String?

    var showReview = false

    // MARK: - Initializer

    // MARK: - Initializer

    init(
        processor: ImageProcessorProtocol? = nil,
        scanner: CouponScannerServiceProtocol? = nil,
        intelligenceEngine: CouponIntelligenceEngineProtocol? = nil
    ) {

        self.processor = processor ?? ImageProcessor()

        self.scanner = scanner ?? CouponScannerService()

        self.intelligenceEngine = intelligenceEngine ?? CouponIntelligenceEngine()
    }

    // MARK: - Scan

    func scan(
        image: UIImage
    ) async {

        guard !isScanning else {

            logger.warning("Ignoring duplicate scan request.")

            return
        }

        logger.info("📷 Scan Started")

        let start = ContinuousClock.now

        isScanning = true
        errorMessage = nil

        defer {

            isScanning = false

            let duration = start.duration(to: .now)

            logger.info("✅ Scan Finished")
            logger.info("⏱️ Total Duration: \(String(describing: duration))")
        }

        do {

            logger.info("🖼️ Processing Image")

            let processedImage = processor.process(
                image
            )

            logger.info("🔍 Running OCR")

            let scanResult = try await scanner.recognizeText(
                from: processedImage
            )

            logger.info("✅ OCR Complete")
            logger.info("📄 Recognized Text Count: \(scanResult.recognizedTexts.count)")

            logger.info("🧠 Running Apple Intelligence")

            draft = try await intelligenceEngine.extractCoupon(
                from: scanResult
            )

            logger.info("✅ AI Extraction Complete")

            if let draft {

                logger.info("🏪 Merchant: \(draft.merchantName)")
                logger.info("🎁 Coupon: \(draft.couponCode)")
                logger.info("📅 Expiry: \(draft.expiryDate?.description ?? "nil")")
            }

            showReview = true

            logger.info("➡️ Navigating to Review Screen")

        } catch let error as AIValidationError {

            logger.warning("⚠️ AI Validation Failed: \(error.localizedDescription)")

            errorMessage = error.localizedDescription

        } catch let error as AIError {

            logger.error("❌ Foundation Model Error: \(error.localizedDescription)")

            errorMessage = error.localizedDescription

        } catch {

            logger.error("❌ Scanner Error: \(error.localizedDescription)")

            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Reset

    func reset() {

        logger.info("🔄 Reset Scanner State")

        draft = nil
        errorMessage = nil
        showReview = false
        isScanning = false
    }
}
