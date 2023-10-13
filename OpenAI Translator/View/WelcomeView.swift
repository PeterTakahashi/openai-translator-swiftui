//
//  WelcomeView.swift
//  OpenAI Translator
//
//  Created by Apple on 2023/10/12.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            AnimatedBackground()
            VStack {
                HStack {
                    Image(colorScheme == .dark ? "OpenAIIconForDark" : "OpenAIIcon").resizable().frame(width: 30, height: 30)
                    Text("OpenAI Translator")
                        .font(.title)
                        .bold()
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

#Preview("Light mode") {
    WelcomeView()
}
#Preview("Dark mode") {
    WelcomeView().environment(\.colorScheme, .dark).background(.black)
}
