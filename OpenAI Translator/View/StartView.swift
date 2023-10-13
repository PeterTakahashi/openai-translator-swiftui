//
//  StartView.swift
//  OpenAI Translator
//
//  Created by Apple on 2023/10/12.
//

import SwiftUI

struct StartView: View {
    @State private var isShowOpenAIAPI = false

    var body: some View {
        NavigationView {
            NavigationLink {
                OpenAIApiKeyView()
            } label: {
                WelcomeView()
            }
        }.accentColor(.primary)
    }
}

#Preview("Light mode") {
    StartView()
}
#Preview("Dark mode") {
    StartView().environment(\.colorScheme, .dark)
}

