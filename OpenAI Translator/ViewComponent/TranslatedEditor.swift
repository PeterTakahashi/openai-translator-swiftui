//
//  TranslatedEditor.swift
//  OpenAI Translator
//
//  Created by Apple on 2023/10/13.
//

import SwiftUI

struct TranslatedEditor: View {
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
            if (!isOutputTextEditorFocused) {
                ZStack(alignment: .topLeading) {
                    ZStack(alignment: .bottomTrailing) {
                        ZStack(alignment: .bottomLeading) {
                            TextEditor(text: $inputText)
                                .focused($isInputTextEditorFocused)
                            if (!isInputTextEditorFocused && !inputText.isEmpty) {
                                Button(action: { inputText = "" }) {
                                    Image(systemName: "trash")
                                        .padding()
                                        .foregroundColor(.black)
                                }.padding(4)
                            }
                        }
                        if (isInputTextEditorFocused) {
                            Button(action: {
                                Task {
                                    isInputTextEditorFocused.toggle()
                                    await submit()
                                }
                            }) {
                                Image(systemName: "arrow.forward.circle.fill")
                                    .padding()
                                    .font(.title)
                                    .foregroundColor(Color.black.opacity(0.8))
                            }
                            .padding(4)
                        } else if (!inputText.isEmpty) {
                            Button(action: { copyText(text: inputText) }) {
                                Image(systemName: "doc.on.doc")
                                    .padding()
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                            .padding(4)
                        }
                    }
                    if inputText.isEmpty {
                        placeholderView.onTapGesture {
                            self.isInputTextEditorFocused = true
                        }
                    }
                    if (inputText.isEmpty && !isInputTextEditorFocused) {
                        HStack {
                            Button(action: { Task { pasteText } }) {
                                HStack {
                                    Image(systemName: "doc.on.clipboard")
                                        .foregroundColor(.white)
                                    Text("Paste")
                                        .foregroundColor(.white)
                                }
                                .padding([.leading, .trailing], 10)
                                .padding([.top, .bottom], 5)
                                .background(colorScheme == .dark ? Color.gray.opacity(0.4) : Color.gray)
                                .cornerRadius(5)
                            }
                            Spacer()
                        }.padding(.top, 70)
                    }
                }
            }
            
            if (!isInputTextEditorFocused && !isOutputTextEditorFocused) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.5))
                    .padding()
            }
            
            if (!isInputTextEditorFocused) {
                ZStack(alignment: .bottomTrailing) {
                    ZStack(alignment: .bottomLeading) {
                        TextEditor(text: $outputText).focused($isOutputTextEditorFocused).disabled(outputText.isEmpty)
//                        if (!isOutputTextEditorFocused) {
//                            Button(action: {
//                            }) {
//                                Image(systemName: "speaker.wave.2")
//                                    .padding()
//                                    .foregroundColor(.black)
//                            }
//                            .padding(4)
//                        }
                    }
                    
                    if (!isOutputTextEditorFocused && !outputText.isEmpty) {
                        Button(action: { copyText(text: outputText) }) {
                            Image(systemName: "doc.on.doc")
                                .padding()
                                .foregroundColor(.black)
                        }
                        .padding(4)
                    } else if (isOutputTextEditorFocused) {
                        Button(action: {
                            isOutputTextEditorFocused = false
                        }) {
                            Image(systemName: "arrow.forward.circle.fill")
                                .padding()
                                .font(.title)
                                .foregroundColor(Color.black.opacity(0.8))
                        }
                        .padding(4)
                    }
                }
            }
        }.padding()
    }
    
    func copyText(text: String) {
        UIPasteboard.general.string = text
    }
    
    @MainActor
    private func pasteText() async {
        if let string = UIPasteboard.general.string {
            inputText = string
            await submit()
        }
    }

    @ViewBuilder
    private var placeholderView: some View {
        if inputText.isEmpty {
            Text("Enter text")
                .foregroundColor(.gray)
                .padding(.all, 8)
        }
    }
}
