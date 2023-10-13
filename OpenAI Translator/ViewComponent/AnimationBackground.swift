//
//  AnimatedBackground.swift
//  OpenAI
//
//  Created by Apple on 2023/04/14.
//

import SwiftUI

struct AnimatedBackground: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var startAnimation = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<50) { _ in
                    Circle()
                        .fill(colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.1))
                        .frame(width: CGFloat.random(in: 10...30), height: CGFloat.random(in: 10...30))
                        .position(x: CGFloat.random(in: 0...geometry.size.width), y: CGFloat.random(in: 0...geometry.size.height))
                        .scaleEffect(self.startAnimation ? 1 : 0)
                        .animation(
                            Animation.easeInOut(duration: 6).repeatForever().speed(Double.random(in: 0.4...5)),
                            value: self.startAnimation
                        )
                }
            }
            .onAppear {
                self.startAnimation = true
            }
        }
    }
}

struct AnimatedBackground_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedBackground()
    }
}
