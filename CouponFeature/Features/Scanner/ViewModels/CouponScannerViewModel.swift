//
//  CouponScannerViewModel.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//



import Foundation
import UIKit
import Observation

@Observable
@MainActor
final class CouponScannerViewModel {

    // MARK: Dependencies

    private let processor: ImageProcessorProtocol
    private let scanner: CouponScannerServiceProtocol
    private let parser: CouponParserProtocol

    // MARK: UI State

    var isScanning = false

    var draft: CouponDraft?

    var errorMessage: String?

    var showReview = false

    // MARK: Init

    init(
        processor: ImageProcessorProtocol = ImageProcessor(),
        scanner: CouponScannerServiceProtocol = CouponScannerService(),
        parser: CouponParserProtocol = CouponParser()
    ) {

        self.processor = processor
        self.scanner = scanner
        self.parser = parser
    }

    // MARK: Scan

    func scan(
        image: UIImage
    ) async {

        print("🚀 Scan Started")

        isScanning = true
        errorMessage = nil

        defer {

            isScanning = false
            print("🏁 Scan Finished")
        }

        do {

            print("🖼 Processing Image")

            let processedImage = processor.process(image)

            print("🔍 Running OCR")

            let result = try await scanner.recognizeText(
                from: processedImage
            )

            print("✅ OCR Complete")
            print("Recognized Text Count:", result.recognizedTexts.count)

            draft = parser.parse(
                from: result
            )

            print("📄 Draft Created")

            showReview = true

            print("➡️ Navigation Triggered")

        } catch {

            print("❌ Scanner Error:", error)

            errorMessage = error.localizedDescription
        }
    }

    // MARK: Reset

    func reset() {

        draft = nil
        errorMessage = nil
        showReview = false
        isScanning = false
    }
}
