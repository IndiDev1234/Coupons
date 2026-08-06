//
//  CouponPromptBuilder.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation

enum CouponPromptBuilder {

    static func extractionPrompt(
        from ocrText: String
    ) -> String {

        """
        You are an intelligent coupon extraction assistant.

        Your task is to analyze OCR text extracted from a shopping coupon.

        Carefully correct OCR mistakes when obvious.

        Extract the following information.

        Merchant Name

        Coupon Title

        Coupon Code

        Discount Type

        Discount Value

        Minimum Purchase

        Expiry Date

        Category

        Terms Summary

        Confidence Score

        Rules:

        • Never invent information.

        • If information is missing return null.

        • Correct OCR mistakes only when obvious.

        • Return ONLY valid JSON.

        • Never use markdown.

        • Never explain your answer.

        OCR TEXT

        \(ocrText)
        """
    }
}
