//
//  RippleRelaxView.swift
//  StillSpace
//
//  Created by admin64 on 31/03/25.
//

import SwiftUI
// MARK: - Ripple Relax Activity
struct RippleRelaxView: View {
    // State for tracking ripples
    @State private var ripples: [Ripple] = []
    // State for tracking if sound is enabled
    @State private var soundEnabled = true
    // State for tracking if tips are showing
    @State private var showingTip = false
    // State for water base animation
    @State private var waterOffset: CGFloat = 0
    // State for ambient sound volume
    @State private var ambientVolume: Double = 0.5
    
    // Timer for gentle water movement even without interaction
    let ambientTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // Water background
            ZenTheme.background
                .edgesIgnoringSafeArea(.all)
            
            // Header controls
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        soundEnabled.toggle()
                        // Here you would control actual sound playback
                        // playSound(enabled: soundEnabled)
                    }) {
                        Image(systemName: soundEnabled ? "speaker.wave.2.fill" : "speaker.slash.fill")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(ZenTheme.text.opacity(0.7))
                    }
                    .padding()
                    
                    // Info button
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
            }
            .zIndex(2)
            
       
            ZStack {
               
                WaterWaves(yOffset: waterOffset)
                    .fill(ZenTheme.water.opacity(0.3))
                    .frame(height: 600)
                    .offset(y: 100)
                    .onReceive(ambientTimer) { _ in
                        withAnimation(.easeInOut(duration: 2)) {
                            waterOffset = waterOffset == 0 ? 5 : 0
                        }
                    }
                
                // Ripple effects layer
                ForEach(ripples) { ripple in
                    RippleView(ripple: ripple)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
           
            .onTapGesture { location in
                createRipple(at: location)
            }
            
         
            VStack {
                Spacer()
                
                if soundEnabled {
                    HStack {
                        Image(systemName: "speaker.fill")
                            .foregroundColor(ZenTheme.text.opacity(0.5))
                        
                        Slider(value: $ambientVolume, in: 0...1)
                            .accentColor(ZenTheme.water)
                            .onChange(of: ambientVolume) { newValue in
                                // Here you would adjust actual sound volume
                                // adjustVolume(to: newValue)
                            }
                        
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(ZenTheme.text.opacity(0.5))
                    }
                    .padding()
                    .background(ZenTheme.background.opacity(0.7))
                    .cornerRadius(20)
                    .padding()
                }
            }
         
            if showingTip {
                VStack(alignment: .leading, spacing: 12) {
                    Text("ripple relax tips:")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(ZenTheme.text)
                    
                    Text("• tap anywhere to create ripples")
                    Text("• focus on the expanding circles")
                    Text("• synchronize your breathing with the ripples")
                    Text("• imagine your stress dissolving with each ripple")
                    Text("• try tapping in rhythm with your heartbeat")
                }
                .font(.system(size: 14, weight: .light))
                .foregroundColor(ZenTheme.text.opacity(0.7))
                .padding()
                .background(ZenTheme.background)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.1), radius: 8)
                .padding()
                .frame(maxWidth: 300)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(ZenTheme.text.opacity(0.1), lineWidth: 1)
                )
                .transition(.opacity)
                .zIndex(3)
                .onTapGesture {
                    showingTip = false
                }
            }
            
           
            Text("tap anywhere to create ripples")
                .font(.system(size: 16, weight: .light))
                .foregroundColor(ZenTheme.text.opacity(0.7))
                .padding()
                .background(ZenTheme.background.opacity(0.7))
                .cornerRadius(20)
                .opacity(ripples.isEmpty ? 1 : 0)
                .animation(.easeInOut(duration: 1.5), value: ripples.isEmpty)
        }
        .navigationBarHidden(true)
    }
    
    // Function to create a new ripple
    private func createRipple(at position: CGPoint) {
        // Create a new ripple
        let newRipple = Ripple(position: position)
        ripples.append(newRipple)
        
        // Play sound if enabled
        if soundEnabled {
            // Here you would play the actual sound
            // playRippleSound(volume: ambientVolume)
        }
        
        // Remove ripple after animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if let index = ripples.firstIndex(where: { $0.id == newRipple.id }) {
                ripples.remove(at: index)
            }
        }
    }
}

// Shape for ambient water waves
struct WaterWaves: Shape {
    var yOffset: CGFloat
    
    var animatableData: CGFloat {
        get { yOffset }
        set { yOffset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        // Start at the bottom left
        path.move(to: CGPoint(x: 0, y: height))
        
        // Draw a series of curves to simulate water
        let midPoint = width / 2
        
        // First wave
        path.addCurve(
            to: CGPoint(x: midPoint, y: height * 0.9 + yOffset),
            control1: CGPoint(x: width * 0.25, y: height * 0.95 - yOffset),
            control2: CGPoint(x: width * 0.35, y: height * 0.85 + yOffset)
        )
        
        // Second wave
        path.addCurve(
            to: CGPoint(x: width, y: height * 0.95),
            control1: CGPoint(x: width * 0.65, y: height * 0.95 - yOffset),
            control2: CGPoint(x: width * 0.75, y: height * 0.98 + yOffset)
        )
        
        // Complete the rectangle
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        
        return path
    }
}




struct RippleView: View {
    let ripple: Ripple
    
   
    @State private var scale: CGFloat = 0.1
    @State private var opacity: Double = 0.8
    
    var body: some View {
        ZStack {
          
            ForEach(0..<4) { i in
                Circle()
                    .stroke(
                        ripple.baseColor.opacity(opacity - Double(i) * 0.15),
                        lineWidth: 2 - CGFloat(i) * 0.4
                    )
                    .scaleEffect(scale - CGFloat(i) * 0.1)
                    .position(ripple.position)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 3.0)) {
                scale = 3.0
                opacity = 0
            }
        }
    }
}
