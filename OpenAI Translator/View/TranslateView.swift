//
//  TranslateView.swift
//  OpenAI Translator
//
//  Created by Apple on 2023/10/12.
//

import SwiftUI

struct TranslateView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var inputText = ""
    @State private var outputText = ""
    @State private var inputLanguage = "en"
    @State private var outputLanguage = "ja"
    @State private var changeType = "Translate"
    @State private var isInProcess = false
    @FocusState private var isInputTextEditorFocused: Bool
    @FocusState private var isOutputTextEditorFocused: Bool
    var chatgptApi: ChatGPTAPI = ChatGPTAPI()

    private static let modelKey = "selectedModelKey"
    private static let openAIApiKeyKey = "openAIApiKeyKey"

    @AppStorage(modelKey) private var selectedModel = "gpt-3.5"
    @AppStorage(openAIApiKeyKey) private var openAIApiKey = ""
    
    init() {
        chatgptApi.setModel(selectedModel: selectedModel)
        chatgptApi.openAIApiKey = openAIApiKey
    }
    
    var body: some View {
            NavigationView {
                VStack {
                    VStack {
                        VStack {
                            TranslatedEditor(inputText: $inputText, outputText: $outputText, inputLanguage: $inputLanguage, outputLanguage: $outputLanguage, changeType: $changeType, isInProcess: $isInProcess, isInputTextEditorFocused: $isInputTextEditorFocused, isOutputTextEditorFocused: $isOutputTextEditorFocused, submit: submit)
                        }.background(oppositeColorForScheme).clipShape(
                            .rect(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 40,
                                bottomTrailingRadius: 40,
                                topTrailingRadius: 0
                            )
                        )

                        TranslateButtons(inputText: $inputText, outputText: $outputText, inputLanguage: $inputLanguage, outputLanguage: $outputLanguage, changeType: $changeType, isInProcess: $isInProcess, isInputTextEditorFocused: $isInputTextEditorFocused, isOutputTextEditorFocused: $isOutputTextEditorFocused, submit: submit).background(colorScheme == .dark ? Color.gray.opacity(0.4) : Color.gray.opacity(0.1))
                    }
                }
                .background(oppositeColorForScheme)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        ToolbarPrincipalView().onTapGesture(perform: {
                            isInputTextEditorFocused = false
                            isOutputTextEditorFocused = false
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SettingsView(chatgptApi: chatgptApi)) {
                            Image(systemName: "gear")
                                .foregroundColor(colorForScheme)
                        }
                    }
                }
            }.accentColor(.black)
        }
    
    @MainActor
    private func submit() async {
        if (inputText.isEmpty) {
            return
        }
        chatgptApi.deleteHistoryList()
        self.isInProcess = true
        self.outputText = ""
        let text = createTextForChatGPT(changeType: changeType, inputText: inputText, outputLanguage: outputLanguage)
        do {
            let stream = try await chatgptApi.sendMessageStream(text: text)
            for try await text in stream {
                self.outputText += text
            }
        } catch {
            self.outputText = error.localizedDescription
        }
        self.isInProcess = false
    }
    
    var colorForScheme: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var oppositeColorForScheme: Color {
        colorScheme == .dark ? .black : .white
    }
}

#Preview("Light mode") {
    TranslateView()
}
#Preview("Dark mode") {
    TranslateView().environment(\.colorScheme, .dark)
}

