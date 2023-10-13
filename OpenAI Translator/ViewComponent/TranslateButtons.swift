//
//  TranslateButtons.swift
//  OpenAI Translator
//
//  Created by Apple on 2023/10/13.
//

import SwiftUI

struct TranslateButtons: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var inputText: String
    @Binding var outputText: String
    @Binding var inputLanguage: String
    @Binding var outputLanguage: String
    @Binding var changeType: String
    @Binding var isInProcess: Bool
    @FocusState.Binding var isInputTextEditorFocused: Bool
    @FocusState.Binding var isOutputTextEditorFocused: Bool
    var submit: () async -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                if (changeType == "Translate") {
                    LanguagePicker(languages: languages, selectedLanguage: $inputLanguage)
                        .padding(5)
                        .background(oppositeColorForScheme)
                        .cornerRadius(10)
                        .pickerStyle(MenuPickerStyle())
                        .foregroundColor(colorForScheme)
                        .accentColor(colorForScheme)
                        .frame(width: 150)
                    
                    Button(action: swapLanguages) {
                        Image(systemName: "arrow.left.arrow.right")
                            .font(.title2)
                            .foregroundColor(colorForScheme)
                    }
                    LanguagePicker(languages: languages, selectedLanguage: $outputLanguage)
                        .padding(5)
                        .background(oppositeColorForScheme)
                        .cornerRadius(10)
                        .pickerStyle(MenuPickerStyle())
                        .foregroundColor(colorForScheme)
                        .accentColor(colorForScheme)
                        .frame(width: 150)
                }
                Spacer()
            }.frame(height: changeType == "Translate" ? 30 : 0).padding(.top, changeType == "Translate" ? 20 : 0).padding(.bottom, (!isInputTextEditorFocused && !isOutputTextEditorFocused) ? 0 : 20)

            if (!isInputTextEditorFocused && !isOutputTextEditorFocused) {
                HStack {
                    if (changeType != "Translate") {
                        LanguagePicker(languages: languages, selectedLanguage: $outputLanguage)
                            .padding(5)
                            .background(oppositeColorForScheme)
                            .cornerRadius(10)
                            .pickerStyle(MenuPickerStyle())
                            .foregroundColor(colorForScheme)
                            .accentColor(colorForScheme)
                            .frame(width: 150)
                    } else {
                        Spacer().frame(width: 150)
                    }
                    Spacer()
                    Button (action: {
                        Task {
                            await submit()
                        }
                    }) {
                        ZStack {
                            if (isInProcess) {
                                Spinner().frame(width: 60, height: 60)
                            }
                            Image(systemName: "lightspectrum.horizontal")
                                .font(.system(size: 50))
                                .foregroundColor(colorForScheme)
                        }
                    }
                    Spacer()
                    Picker("Change Types", selection: $changeType) {
                        ForEach(changeTypes, id: \.self) { changeType in
                            Text(LocalizedStringKey(changeType)).tag(changeType)
                        }
                    }
                    .background(oppositeColorForScheme)
                    .cornerRadius(10)
                    .pickerStyle(MenuPickerStyle())
                    .foregroundColor(colorForScheme)
                    .accentColor(colorForScheme)
                    .frame(width: 150)
                }.padding(.top, 15)
            }
        }
    }

    func swapLanguages() {
        let temp = inputLanguage
        inputLanguage = outputLanguage
        outputLanguage = temp
        
        let tempText = inputText
        inputText = outputText
        outputText = tempText
    }
    
    var colorForScheme: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var oppositeColorForScheme: Color {
        colorScheme == .dark ? .black : .white
    }
}
