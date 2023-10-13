import SwiftUI

struct ContentView: View {
    private static let openAIApiKeyKey = "openAIApiKeyKey"
    @AppStorage(openAIApiKeyKey) private var openAIApiKey = ""

    var body: some View {
        if (openAIApiKey.isEmpty) {
            StartView()
        } else {
            TranslateView()
        }
    }
}

#Preview("Light mode") {
    ContentView()
}

#Preview("Dark mode") {
    ContentView().environment(\.colorScheme, .dark).background(.black)
}
