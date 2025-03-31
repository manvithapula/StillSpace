//
//  ZenTheme.swift
//  StillSpace
//
//  Created by admin64 on 30/03/25.
//


import SwiftUI


// MARK: - Main App View
struct StillSpace: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [ZenTheme.background, ZenTheme.background.opacity(0.9)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                // Content
                VStack(spacing: 40) {
                    // App header
                    Text("Welcome to StillSpace")
                        .font(.system(size: 28, weight: .light))
                        .foregroundColor(ZenTheme.text)
                        .tracking(2)
                    
                    // Activity buttons grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ActivityCard(
                            title: "scribble pad",
                            icon: "scribble",
                            color: ZenTheme.secondary,
                            destination: AnyView(ScribblePadView())
                            
                            )
                        ActivityCard(
                            title: "breathing ball",
                            icon: "circle.dashed",
                            color: ZenTheme.primary,
                            destination: AnyView(BreathingBallView())
                        )
                       
                        ActivityCard(
                            title: "ripple relax",
                            icon: "water.waves",
                            color: ZenTheme.water,
                            destination: AnyView(RippleRelaxView())
                        )
          
                        ActivityCard(
                            title:"pebble stack",
                            icon: "circle.grid.3x3",
                            color: ZenTheme.stone,
                            destination: AnyView(BreathingBallView())
                            )
                        
                        ActivityCard(
                            title: "zen garden",
                            icon: "leaf",
                            color: ZenTheme.sand,
                            destination: AnyView(BreathingBallView())
                        )
          
                       
                    }
                    .padding(.horizontal)
                    
                    // Quote of the day
                    Text("breathe in peace, breathe out stress")
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(ZenTheme.text.opacity(0.7))
                        .italic()
                        .padding(.top, 20)
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Activity Card Component
struct ActivityCard: View {
    let title: String
    let icon: String
    let color: Color
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .foregroundColor(color)
                
                Text(title)
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(ZenTheme.text)
                    .multilineTextAlignment(.center)
            }
            .frame(minWidth: 120, minHeight: 120)
            .padding()
            .background(ZenTheme.background)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

