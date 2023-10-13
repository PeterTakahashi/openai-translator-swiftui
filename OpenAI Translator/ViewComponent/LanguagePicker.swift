//
//  LanguagePicker.swift
//  OpenAI Translator
//
//  Created by Apple on 2023/10/12.
//

import SwiftUI

struct LanguagePicker: View {
    var languages: [(displayName: String, code: String)]
    @Binding var selectedLanguage: String

    var body: some View {
        Picker(LocalizedStringKey("Input Language"), selection: $selectedLanguage) {
            ForEach(languages, id: \.code) { language in
                Text(LocalizedStringKey(language.displayName)).tag(language.code)
            }
        }
    }
}
