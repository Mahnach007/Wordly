import SwiftUI

struct CardComponent: View {
    var word: String = "Car"
    var definition: String = "La machina"
    var language: String = "Choose Language"
    let offset = 5.0
    @State private var suggestions: [String] = ["Suggerimento 1", "Suggerimento 2", "Suggerimento 3"] // Sample suggestions

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
                UnderlineTextField(wordType: "Word")
                UnderlineTextField(text: "cecw", wordType: "Definition")

                
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: 50 * CGFloat((1 + suggestions.count))) // Remove fixed maxHeight to allow it to expand
        .padding()
    }
}

struct UnderlineTextField: View {
    
    @State var text = ""
    @State var wordType = ""
    @State var language = "Choose Language"
    @State private var suggestions: [String] = ["everv", "rever"] // Sample suggestions


    var body: some View {
        VStack {
            // Text input field
            HStack {
                TextField("", text: $text)
                    .title3Style()
                    .underlineTextField()
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
            if text.isEmpty {
                
            } else {
                VStack(alignment: .leading, spacing: 3) {
                    ForEach(suggestions, id: \.self) { suggestion in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(AppColors.shadowBlue)
                            .frame(maxWidth: .infinity, minHeight: 30)
                            .overlay(
                                Text(suggestion).title3Style()                                .padding(.horizontal, 8),
                                alignment: .leading
                            )
                            .padding(.horizontal, 1)
                    }
                }
            }
        }
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .shadow(radius: 3, y: -4)
            .foregroundStyle(Color.white)
            .foregroundColor(AppColors.shadowBlue)
    }
}

#Preview {
    CardComponent()
}
