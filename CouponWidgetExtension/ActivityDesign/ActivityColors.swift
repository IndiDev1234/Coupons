//
//  ActivityColors.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//

import SwiftUI

enum ActivityColors {

    static let primaryText: Color = .primary

    static let secondaryText: Color = .secondary

    static let success: Color = Color(white: 0.88) // Silver/light grey for high-contrast active text

    static let warning: Color = .orange

    static let error: Color = .red

    static let accent: Color = .blue

    static let cardBackground: Color = .clear

    // Premium gradients for badges and highlights
    static let successGradient = LinearGradient(
        colors: [Color(white: 0.15), Color(white: 0.30)], // Obsidian / Dark Space Grey
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let warningGradient = LinearGradient(
        colors: [.orange, .yellow],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let errorGradient = LinearGradient(
        colors: [.red, .pink],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let redeemedGradient = LinearGradient(
        colors: [Color(white: 0.45), Color(white: 0.6)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let accentGradient = LinearGradient(
        colors: [.blue, .purple],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
