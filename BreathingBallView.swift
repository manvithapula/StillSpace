//
//  BreathingBallView.swift
//  StillSpace
//
//  Created by admin64 on 30/03/25.
//

import SwiftUI

struct BreathingBallView: View {
    
    @State private var scale: CGFloat = 1.0
    @State private var breathingIn = true
    @State private var instructionText = "breathe in..."
    @State private var breathCount = 0
    @State private var showingTip = false
    let breathTimer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            // Bg
            ZenTheme.background
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 60) {
                HStack {
                    Spacer()
                    Button(action: {
                        showingTip.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(ZenTheme.text.opacity(0.7))
                    }
                    .padding()
                }
                Spacer()
               
                Text(instructionText)
                    .font(.system(size: 24, weight: .light))
                    .foregroundColor(ZenTheme.text)
                    .tracking(1)
                    .opacity(0.8)
                    .animation(.easeInOut(duration: 1), value: instructionText)
                
                
                Text("\(breathCount) breaths completed")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(ZenTheme.text.opacity(0.5))
                    .padding(.bottom, 20)
                
                // ripple animation
                ZStack {
                    ForEach(0..<3) { i in
                        Circle()
                            .stroke(ZenTheme.accent.opacity(0.3), lineWidth: 1)
                            .scaleEffect(scale + CGFloat(i) * 0.1)
                            .opacity(breathingIn ? 0.3 : 0)
                    }
                    
                    // breathing ball
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [ZenTheme.accent, ZenTheme.primary]),
                                center: .center,
                                startRadius: 5,
                                endRadius: 120
                            )
                        )
                        .frame(width: 120, height: 120)
                        .scaleEffect(scale)
                }
                .animation(.easeInOut(duration: 4), value: scale)
                .onReceive(breathTimer) { _ in
                    breathingIn.toggle()
                    scale = breathingIn ? 1.8 : 1.0
                    instructionText = breathingIn ? "breathe in" : "breathe out"
                    if !breathingIn {
                        breathCount += 1
                    }
                }
                
                Spacer()
                
                // info
                if showingTip {
                    Text("box breathing technique: breathe in for 4 seconds, hold for 4, exhale for 4, hold for 4")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(ZenTheme.text.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(ZenTheme.background)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        .padding()
                        .transition(.opacity)
                        .animation(.easeInOut, value: showingTip)
                }
            }
        }
    }
}
