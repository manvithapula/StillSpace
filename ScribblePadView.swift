//
//  ScribblePadView.swift
//  StillSpace
//
//  Created by admin64 on 31/03/25.
//
import SwiftUI

// MARK: - Scribble Pad Activity
struct ScribblePadView: View {
 
    @State private var lines: [Line] = []
    @State private var selectedColor: Color = .black
    @State private var lineWidth: CGFloat = 5.0
    @State private var showingColorOptions = false
    @State private var showingTip = false
    let colorOptions: [Color] = [
        .black,
        ZenTheme.primary,
        ZenTheme.accent,
        ZenTheme.secondary,
        ZenTheme.water,
        Color.red.opacity(0.7),
        Color.orange.opacity(0.7),
        Color.yellow.opacity(0.7),
        Color.green.opacity(0.7),
        Color.blue.opacity(0.7),
        Color.purple.opacity(0.7),
        Color.pink.opacity(0.7)
    ]
    
    var body: some View {
        ZStack {
            // Background
            ZenTheme.background
                .edgesIgnoringSafeArea(.all)
            
            VStack {
               
                HStack {
                    Spacer()
                    Button(action: {
                        lines = []
                    }) {
                        Text("clear")
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(ZenTheme.text.opacity(0.7))
                    }
                    .padding(.horizontal)
                    
                   
                    Button(action: {
                        showingColorOptions.toggle()
                    }) {
                        Circle()
                            .fill(selectedColor)
                            .frame(width: 24, height: 24)
                            .overlay(
                                Circle()
                                    .stroke(ZenTheme.text.opacity(0.3), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal)
                    
                    // Info
                    Button(action: {
                        showingTip.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(ZenTheme.text.opacity(0.7))
                    }
                    .padding()
                }
                
                // Drawing canvas
                Canvas { context, size in
                    for line in lines {
                        var path = Path()
                        path.addLines(line.points)
                        
                        context.stroke(
                            path,
                            with: .color(line.color),
                            lineWidth: line.width
                        )
                    }
                }
                .background(ZenTheme.background)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { value in
                            let position = value.location
                            
                            if value.translation == .zero {
                                let newLine = Line(
                                    points: [position],
                                    color: selectedColor,
                                    width: lineWidth
                                )
                                lines.append(newLine)
                            } else if let lastIdx = lines.indices.last {
                                lines[lastIdx].points.append(position)
                            }
                        }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
              
                HStack {
                    Text("stroke")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(ZenTheme.text.opacity(0.7))
                    
                    Slider(value: $lineWidth, in: 1...20)
                        .accentColor(selectedColor)
                   
                    Circle()
                        .fill(selectedColor)
                        .frame(width: lineWidth, height: lineWidth)
                }
                .padding()
                .background(ZenTheme.background)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 5)
                .padding()
            }
            
        
            if showingColorOptions {
                VStack {
                    Text("choose a color")
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(ZenTheme.text)
                        .padding(.top)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 15) {
                        ForEach(0..<colorOptions.count, id: \.self) { index in
                            let color = colorOptions[index]
                            
                            Circle()
                                .fill(color)
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Circle()
                                        .stroke(color == selectedColor ? ZenTheme.text : Color.clear, lineWidth: 2)
                                )
                                .onTapGesture {
                                    selectedColor = color
                                    showingColorOptions = false
                                }
                        }
                    }
                    .padding()
                    Button("cancel") {
                        showingColorOptions = false
                    }
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(ZenTheme.text.opacity(0.7))
                    .padding(.bottom)
                }
                .padding()
                .background(ZenTheme.background)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10)
                .frame(width: 250)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(ZenTheme.text.opacity(0.1), lineWidth: 1)
                )
                .transition(.scale)
                .zIndex(1)
            }
            
            if showingTip {
                VStack(alignment: .leading, spacing: 10) {
                    Text("scribble tips:")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(ZenTheme.text)
                    
                    Text("• Draw freely without judgment")
                    Text("• Use colors to express different emotions")
                    Text("• Try closing your eyes while drawing")
                    Text("• Focus on the sensation rather than the result")
                    Text("• Breathe deeply while scribbling")
                }
                .font(.system(size: 14, weight: .light))
                .foregroundColor(ZenTheme.text.opacity(0.7))
                .padding()
                .background(ZenTheme.background)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.1), radius: 10)
                .padding()
                .frame(maxWidth: 300)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(ZenTheme.text.opacity(0.1), lineWidth: 1)
                )
                .transition(.opacity)
                .zIndex(1)
                .onTapGesture {
                    showingTip = false
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showingColorOptions)
        .animation(.easeInOut(duration: 0.3), value: showingTip)
        .navigationBarHidden(true)
    }
}

