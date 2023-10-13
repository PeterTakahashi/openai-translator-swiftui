//
//  LoadingButtonModifier.swift
//  OpenAI Translator
//
//  Created by Apple on 2023/10/12.
//

import SwiftUI

struct LoadingButtonModifier: ViewModifier {
    @Binding var isInProcess: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .frame(width: 30, height: 30)
                    .rotationEffect(.degrees(isInProcess ? 360 : 0))
                    .animation(
                        Animation.linear(duration: 1).repeatForever(autoreverses: false)
                    )
                    .foregroundColor(.black)
                    .opacity(isInProcess ? 1 : 0)
                    .padding(5)
            )
            .disabled(isInProcess)
    }
}

