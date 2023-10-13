//
//  ApiKeyModalView.swift
//  OpenAI Translator
//
//  Created by Apple on 2023/10/12.
//

import SwiftUI

struct ApiKeyModalView: View {
    @Environment(\.colorScheme) var colorScheme

    @Binding var apiKey: String
    @Binding var isShowing: Bool
    @State private var newApiKey = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("New API Key", text: $newApiKey)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Button(action: {
                        pasteText()
                        apiKey = newApiKey
                        isShowing = false
                    }) {
                        HStack {
                            Image(systemName: "doc.on.clipboard")
                                .foregroundColor(oppositeColorForScheme)
                            Text("Paste & Update")
                                .foregroundColor(oppositeColorForScheme)
                        }
                        .padding([.leading, .trailing], 10)
                        .padding([.top, .bottom], 5)
                        .background(colorForScheme)
                        .cornerRadius(5)
                    }
                    Button("Update") {
                        apiKey = newApiKey
                        isShowing = false
                    }
                    .padding([.leading, .trailing], 10)
                    .padding([.top, .bottom], 7)
                    .background(colorForScheme)
                    .foregroundColor(oppositeColorForScheme)
                    .cornerRadius(8)
                    .disabled(newApiKey.isEmpty)
                }
                HStack {
                    Spacer()
                    Link("Get OpenAI API key",
                         destination: URL(string: "https://openai.com/blog/openai-api")!).padding(.trailing).padding(.top)
                }
            }
        }.presentationDetents([.height(200)])
    }
    
    func pasteText() {
        if let string = UIPasteboard.general.string {
            newApiKey = string
        }
    }
    
    var colorForScheme: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var oppositeColorForScheme: Color {
        colorScheme == .dark ? .black : .white
    }
}

#Preview("Light mode") {
    ApiKeyModalView(apiKey: .constant("SampleAPIKey"), isShowing: .constant(true))
}

#Preview("Dark mode") {
    ApiKeyModalView(apiKey: .constant("SampleAPIKey"), isShowing: .constant(true)).environment(\.colorScheme, .dark).background(.black)
}
