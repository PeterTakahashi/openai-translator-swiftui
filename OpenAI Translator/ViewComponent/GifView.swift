//
//  GifView.swift
//  OpenAI Translator
//
//  Created by Apple on 2023/10/12.
//
import SwiftUI
import UIKit

struct GifView: UIViewRepresentable {
    let gifName: String

    func makeUIView(context: UIViewRepresentableContext<GifView>) -> UIImageView {
        let imageView = UIImageView()
        if let image = UIImage(named: gifName) {
            imageView.image = image
        }
        imageView.contentMode = .scaleAspectFit
        imageView.startAnimating()
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: UIViewRepresentableContext<GifView>) {
    }
}

#Preview {
    GifView(gifName: "")
}
