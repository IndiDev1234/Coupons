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

    private let scanner: CouponScannerServiceProtocol
    private let parser: CouponParserProtocol

    // MARK: UI State

    var isScanning = false

    var draft: CouponDraft?

    var errorMessage: String?

    var showReview = false

    // MARK: Init

    init(
        scanner: CouponScannerServiceProtocol = CouponScannerService(),
        parser: CouponParserProtocol = CouponParser()
    ) {

        self.scanner = scanner
        self.parser = parser
    }

    // MARK: Scan

    func scan(
        image: UIImage
    ) async {

        isScanning = true
        errorMessage = nil

        defer {

            isScanning = false
        }

        do {

            let result = try await scanner
                .recognizeText(
                    from: image
                )

            draft = parser.parse(
                from: result
            )

            showReview = true

        } catch {

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
