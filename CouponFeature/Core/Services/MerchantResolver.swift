//
//  MerchantResolver 2.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation

struct MerchantResolver: MerchantResolverProtocol {

    private struct MerchantRecord {

        let name: String
        let category: MerchantCategory
        let aliases: [String]
        let confidence: Double
    }

    private let merchants: [MerchantRecord] = [

        MerchantRecord(
            name: "Starbucks",
            category: .food,
            aliases: [
                "STARBUCKS",
                "STARBUCKS INDIA",
                "STARBUCKS COFFEE",
                "STARBUCKS RESERVE"
            ],
            confidence: 1.0
        ),

        MerchantRecord(
            name: "Lifestyle",
            category: .fashion,
            aliases: [
                "LIFESTYLE",
                "LIFESTYLE STORES",
                "LIFESTYLE STORES PVT LTD"
            ],
            confidence: 0.98
        ),

        MerchantRecord(
            name: "Ajio",
            category: .fashion,
            aliases: [
                "AJIO"
            ],
            confidence: 1.0
        ),

        MerchantRecord(
            name: "Myntra",
            category: .fashion,
            aliases: [
                "MYNTRA"
            ],
            confidence: 1.0
        ),

        MerchantRecord(
            name: "Croma",
            category: .electronics,
            aliases: [
                "CROMA"
            ],
            confidence: 1.0
        )
    ]

    func resolve(
        from text: String
    ) -> MerchantMatch? {

        let cleaned = normalize(text)

        for merchant in merchants {

            if let matchedAlias = merchant.aliases.first(
                where: { cleaned.contains($0) }
            ) {

                return MerchantMatch(
                    name: merchant.name,
                    matchedAlias: matchedAlias,
                    confidence: merchant.confidence,
                    category: merchant.category
                )
            }
        }

        return nil
    }
}

// MARK: - Helpers

private extension MerchantResolver {

    func normalize(
        _ text: String
    ) -> String {

        text
            .uppercased()
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: "-", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
