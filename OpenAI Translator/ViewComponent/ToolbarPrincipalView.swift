//
//  ToolbarPrincipalView.swift
//  OpenAI Translator
//
//  Created by Apple on 2023/10/12.
//

import SwiftUI

struct ToolbarPrincipalView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
           HStack {
               Image(colorScheme == .dark ? "OpenAIIconForDark" : "OpenAIIcon").resizable().frame(width: 30, height: 30)
               Text("OpenAI Translator")
                   .font(.title)
                   .bold()
                   .foregroundColor(.primary)
               Spacer()
           }
    }
}

#Preview("Light mode") {
    ToolbarPrincipalView()
}
#Preview("Dark mode") {
    ToolbarPrincipalView().environment(\.colorScheme, .dark).background(.black)
}
