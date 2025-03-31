//
//  DataModel.swift
//  StillSpace
//
//  Created by admin64 on 30/03/25.
//

import SwiftUI


// MARK: - Color Theme
struct ZenTheme {
    static let background = Color(red: 0.96, green: 0.96, blue: 0.94) // Soft off-white
    static let primary = Color(red: 0.53, green: 0.67, blue: 0.65)    // Sage green
    static let secondary = Color(red: 0.86, green: 0.78, blue: 0.70)  // Warm sand
    static let accent = Color(red: 0.69, green: 0.61, blue: 0.85)     // Lavender
    static let water = Color(red: 0.53, green: 0.81, blue: 0.92)      // Soft blue
    static let stone = Color(red: 0.75, green: 0.75, blue: 0.73)      // Neutral stone
    static let sand = Color(red: 0.94, green: 0.87, blue: 0.73)       // Light sand
    static let text = Color(red: 0.25, green: 0.25, blue: 0.25)       // Soft dark
    static let lightText = Color(red: 0.96, green: 0.96, blue: 0.94)  // Soft light
}

// MARK: - Custom UI Components
struct ZenCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(ZenTheme.background)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 2)
    }
}

// Button style with gentle hover effects
struct ZenButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(ZenTheme.primary)
            .foregroundColor(ZenTheme.lightText)
            .cornerRadius(25)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct Line: Identifiable {
    let id = UUID()
    var points: [CGPoint]
    var color: Color
    var width: CGFloat
}


