//
//  RecognizedText.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import Vision

struct RecognizedText: Identifiable {

    let id = UUID()

    let text: String

    let confidence: Float

    let boundingBox: CGRect
}
