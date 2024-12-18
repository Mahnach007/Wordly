import SwiftUI

struct CardComponent: View {
    
    @Binding var word: String
    @Binding var definition: String
    
    var language: String = "Choose Language"
    let offset = 5.0
    
//    @State var isSaved: Bool = false
//    
//    var onSave: ((String, String) -> Void)?
    
    //@State private var suggestions: [String] = ["Suggerimento 1", "Suggerimento 2", "Suggerimento 3"] // Sample suggestions

    var body: some View {
        ZStack {
            // Background shadow rectangle
            RoundedRectangle(cornerRadius: 7)
                .fill(AppColors.shadowBlue)
                .offset(y: offset)

            // Main rounded rectangle
            RoundedRectangle(cornerRadius: 7)
                .fill(AppColors.mainBlue)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(AppColors.shadowBlue, lineWidth: 2)
                )
                .offset(y: false ? offset : 0)

            // Content
            VStack {
                UnderlineTextField(text: $word, wordType: "Word")
                UnderlineTextField(text: $definition, wordType: "Definition")
            }
            .padding()
            
//            if !isSaved {
//                HStack {
//                    Spacer()
//                    VStack {
//                        Button("Save") {
//                            isSaved = true
//                            onSave?(word, definition)
//                        }
//                        .foregroundStyle(.white)
//                        Spacer()
//                    }
//                }
//            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }

}

struct UnderlineTextField: View {
    @Binding var text: String
    @State var wordType = ""
    @State var language = "Choose Language"
    @State private var suggestions: [String] = ["Suggestion 1", "Suggestion 2", "Suggestion 3"] // Sample suggestions
    @State private var showSuggestions: Bool = false // Controls suggestion visibility

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Text input field
            HStack {
                TextField("", text: $text)
                    .title3Style()
                    .underlineTextField()
                    .onChange(of: text) { newValue in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            // Dynamically update suggestions based on text input
                            //updateSuggestions(for: newValue)
                            //showSuggestions = !newValue.isEmpty
                        }
                    }
            }

            // Label and button
            HStack {
                Text(wordType).bodyStyle()
                Spacer()
                Button {
                    // Action for choosing language
                } label: {
                    Text(language).buttonStyle()
                }
            }
            .padding(.horizontal)

            if showSuggestions {
                CardComponentSuggestion(suggestions: suggestions, onSelect: { selectedSuggestion in
                    text = selectedSuggestion // Set text to selected suggestion
                    withAnimation {
                        showSuggestions = false // Hide suggestions
                    }
                })
                .transition(.move(edge: .top).combined(with: .opacity)) // Smooth appearance
            }
        }
    }

//    private func updateSuggestions(for input: String) {
//        if input.isEmpty {
//            suggestions = []
//        } else {
//            // Mock: Filter based on text
//            suggestions = ["Suggestion 1", "Suggestion 2", "Suggestion 3"]
//                .filter { $0.lowercased().contains(input.lowercased()) }
//        }
//    }
}

struct CardComponentSuggestion: View {
    var suggestions: [String]
    var onSelect: (String) -> Void // Callback for selection

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ForEach(suggestions, id: \.self) { suggestion in
                RoundedRectangle(cornerRadius: 3)
                    .fill(AppColors.shadowBlue)
                    .frame(maxWidth: .infinity, minHeight: 30)
                    .overlay(
                        Text(suggestion)
                            .title3Style()
                            .padding(.horizontal, 8),
                        alignment: .leading
                    )
                    .padding(.horizontal, 1)
                    .onTapGesture {
                        onSelect(suggestion) // Pass the selected suggestion
                    }
            }
        }
    }
}



#Preview {
    CardComponent(word: .constant(""), definition: .constant(""))
}
