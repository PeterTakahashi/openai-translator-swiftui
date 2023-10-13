import SwiftUI

struct SettingsView: View {
    var chatgptApi: ChatGPTAPI

    private static let modelKey = "selectedModelKey"
    private static let openAIApiKeyKey = "openAIApiKeyKey"

    @AppStorage(modelKey) private var selectedModel = "gpt-3.5"
    @AppStorage(openAIApiKeyKey) private var openAIApiKey = ""
    @State private var isShowingApiKeyModal = false

    var models = ["gpt-3.5", "gpt-4"]

    var body: some View {
        List {
            Picker("Model", selection: $selectedModel) {
                ForEach(models, id: \.self) { model in
                    Text(model).tag(model)
                }
            }.pickerStyle(SegmentedPickerStyle())
            Button(action: {
                isShowingApiKeyModal = true
            }) {
                HStack {
                    Text("OpenAI API Key")
                    Spacer()
                    Text(openAIApiKey.isEmpty ? "sk-xxxxxx" : "\(String(openAIApiKey.prefix(15)))...").foregroundColor(.gray)
                }
            }.foregroundColor(.primary)
                .sheet(isPresented: $isShowingApiKeyModal) {
                    ApiKeyModalView(apiKey: $openAIApiKey, isShowing: $isShowingApiKeyModal)
            }
            Link("License",
                 destination: URL(string: "https://github.com/PeterTakahashi/openai-translator-swiftui/blob/main/LICENSE")!).foregroundColor(.primary)
            Link("Privacy Policy",
                 destination: URL(string: "https://raw.githubusercontent.com/PeterTakahashi/openai-translator-swiftui/main/privacy-policy.md?token=GHSAT0AAAAAACA5G5RUOLUME3QDITIH5V7OZJJQJMQ")!).foregroundColor(.primary)
            Link("Source Code on Github",
                 destination: URL(string: "https://github.com/PeterTakahashi/openai-translator-swiftui")!).foregroundColor(.primary)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Settings")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
            }
        }.onChange(of: selectedModel) {
            chatgptApi.setModel(selectedModel: selectedModel)
        }.onChange(of: openAIApiKey) {
            chatgptApi.openAIApiKey = openAIApiKey
        }
    }
}

#Preview("Light mode") {
    SettingsView(chatgptApi: ChatGPTAPI())
}
#Preview("Dark mode") {
    SettingsView(chatgptApi: ChatGPTAPI()).environment(\.colorScheme, .dark).background(.black)
}
