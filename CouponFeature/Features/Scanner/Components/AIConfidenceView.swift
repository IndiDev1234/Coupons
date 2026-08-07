//
//  AIConfidenceView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//
//
//  AIConfidenceView.swift
//

import SwiftUI

struct AIConfidenceView: View {

    let confidence: Double?

    private var score: Double {
        confidence ?? 0
    }

    private var percentage: Int {
        Int(score * 100)
    }

    private var color: Color {

        switch score {

        case 0.90...:
            return .green

        case 0.75..<0.90:
            return .blue

        case 0.60..<0.75:
            return .orange

        default:
            return .red
        }
    }

    private var title: String {

        switch score {

        case 0.90...:
            return "Very High Confidence"

        case 0.75..<0.90:
            return "High Confidence"

        case 0.60..<0.75:
            return "Medium Confidence"

        default:
            return "Low Confidence"
        }
    }

    private var stars: Int {

        switch score {

        case 0.90...:
            return 5

        case 0.75..<0.90:
            return 4

        case 0.60..<0.75:
            return 3

        case 0.40..<0.60:
            return 2

        default:
            return 1
        }
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Label(
                "Apple Intelligence",
                systemImage: "apple.intelligence"
            )
            .font(.headline)

            HStack {

                ForEach(0..<5, id: \.self) { index in

                    Image(
                        systemName: index < stars
                        ? "star.fill"
                        : "star"
                    )
                }
                .foregroundStyle(color)

                Spacer()

                Text("\(percentage)%")
                    .font(.title3.bold())
                    .foregroundStyle(color)
            }

            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20
            )
        )
    }
}

#Preview {

    AIConfidenceView(
        confidence: 0.93
    )
}
