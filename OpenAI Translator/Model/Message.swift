//
//  Message.swift
//  OpenAI
//
//  Created by Apple on 2023/04/02.
//

import Foundation

struct Message: Codable {
    let role: String
    let content: String
}
