//
//  CreateTextForChatGPT.swift
//  OpenAI Translator
//
//  Created by Apple on 2023/10/12.
//

import Foundation

func createTextForChatGPT(changeType: String, inputText: String, outputLanguage: String) -> String {
    if (changeType == "Translate") {
        return "You are a professional translation engine.Please translate the text into \(outputLanguage) without explanation.If the text has only one word, return only one word.\n\n`\(inputText)`"
    } else if(changeType == "Analyze") {
        return "`\(inputText)`\n\nYou are a professional translation engine and grammar analyzer.Please translate this text to \(outputLanguage) and explain the grammar in the original text using"
    } else if(changeType == "Summarize") {
        return "`\(inputText)`\n\nYou are a professional text summarizer, you can only summarize the text, don't interpret it.Please summarize this text in the most concise language and must use \(outputLanguage) language!"
    } else if(changeType == "Improvement") {
        return "`\(inputText)`\n\nYou are an expert writer, translate directly without explanation.Please edit the following sentences in \(outputLanguage) to improve clarity, conciseness, and coherence, making them match the expression of native speakers."
    } else if(changeType == "Continue") {
        return "`\(inputText)`\n\nYou are an expert writer, Please include the original text in your reply. Please create a continuation sentence in \(outputLanguage)"
    } else {
        return ""
    }
}
