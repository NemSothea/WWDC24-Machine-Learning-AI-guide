//
//  ContentView.swift
//  Writing Tools
//
//  Created by NEMSOTHEA on 2/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var textContent = """
Şeyma is the kind of person who brings warmth wherever she goes. With a heart as kind as a sunrise and a smile that could brighten even the cloudiest day, she has a way of making everyone around her feel special. Whether it's through her laughter, her endless support, or the way she listens with genuine care, she leaves an unforgettable mark on the people she meets.

Creative, passionate, and full of life, Şeyma is always ready for an adventure. She dreams big and chases those dreams with determination, inspiring others to do the same. Whether she’s exploring new ideas, helping a friend in need, or simply sharing a quiet moment of understanding, she embodies kindness and strength in everything she does.

Her presence is like a melody—soft yet powerful, familiar yet always surprising. She finds beauty in the little things, whether it’s a sunset, a meaningful conversation, or the simple joy of laughter shared with friends. Her heart is as vast as the ocean, filled with love, compassion, and a deep appreciation for life.

On this special day, we celebrate not just another year in her life but the countless moments of happiness, love, and inspiration she has given to those around her. Şeyma, may your birthday be as wonderful as you are, filled with love, laughter, and everything that brings you joy. You are truly one of a kind, and the world is brighter because of you.

Happy Birthday, Şeyma! 🎉🎂💖
"""
    @State var elapsedTime: TimeInterval = 0
    @State var timer: Timer? = nil
    
    var body: some View {
        NavigationStack {
            Form {
                CustomTextView(text: $textContent, onStartTimer: startTimer, onStopTimer: stopTimer)
#if os(macOS)
                    .frame(height:400)
#else
                    .frame(height:500)
#endif
                HStack {
                    Spacer()
                    Text("Elapsed Time: \(String(format: "%.2f", elapsedTime)) seconds")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
           
#if !os(macOS)
.navigationBarTitle("Writing Tools",displayMode:.inline)
#endif

        }
        
    }
    
    func startTimer() {
        stopTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {_ in
            elapsedTime += 0.01
        }
        
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    ContentView()
}
