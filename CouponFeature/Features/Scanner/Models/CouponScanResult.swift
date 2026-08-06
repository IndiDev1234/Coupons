//
//  CouponScanResult.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation

struct CouponScanResult {

    let recognizedTexts: [RecognizedText]

    let scanDate: Date

    init(
        recognizedTexts: [RecognizedText],
        scanDate: Date = .now
    ) {
        self.recognizedTexts = recognizedTexts
        self.scanDate = scanDate
    }
}
