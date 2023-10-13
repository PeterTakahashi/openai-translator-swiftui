//
//  openaiApiKeyView.swift
//  OpenAI Translator
//
//  Created by Apple on 2023/10/12.
//
import SwiftUI

struct OpenAIApiKeyView: View {
    @Environment(\.colorScheme) var colorScheme

    private static let openAIApiKeyKey = "openAIApiKeyKey"
    @AppStorage(openAIApiKeyKey) private var openAIApiKey = ""
    @State private var newApiKey = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("New API Key", text: $newApiKey)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    StyledButton(
                        title: "Paste & Update",
                        systemImage: "doc.on.clipboard",
                        backgroundColor: colorForScheme,
                        foregroundColor: oppositeColorForScheme,
                        action: {
                            pasteText()
                            updateApiKey()
                        }
                    )
                    
                    StyledButton(
                        title: "Update",
                        backgroundColor: colorForScheme,
                        foregroundColor: oppositeColorForScheme,
                        action: updateApiKey
                    )
                    .disabled(newApiKey.isEmpty)
                }
                HStack {
                    Spacer()
                    Link("Get OpenAI API key",
                         destination: URL(string: "https://openai.com/blog/openai-api")!)
                        .padding(.trailing)
                        .padding(.top)
                }
            }
        }.accentColor(.primary).presentationDetents([.height(200)])
    }
    
    func pasteText() {
        if let string = UIPasteboard.general.string {
            newApiKey = string
        }
    }
    
    func updateApiKey() {
        openAIApiKey = newApiKey
    }
    
    var colorForScheme: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var oppositeColorForScheme: Color {
        colorScheme == .dark ? .black : .white
    }
}

struct StyledButton: View {
    var title: String
    var systemImage: String? = nil
    var backgroundColor: Color
    var foregroundColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let systemImage = systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
            }
            .padding([.leading, .trailing], 10)
            .padding([.top, .bottom], 5)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(5)
        }
    }
}


#Preview("Light mode") {
    OpenAIApiKeyView()
}
#Preview("Dark mode") {
    OpenAIApiKeyView().environment(\.colorScheme, .dark)
}
