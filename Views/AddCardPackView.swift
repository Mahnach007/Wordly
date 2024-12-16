//
//  AddCardView.swift
//  Wordly
//
//  Created by Vlad Gotovchykov on 12/12/24.
//

import SwiftUI
import SwiftData

struct AddCardPackView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State var cardPackTitle: String = ""
    
    @State var flashCards: [BindingFlashCard] = []
    @State private var cardPack: CardPack = CardPack(name: "")
    
    var body: some View {
        ZStack {
            AppColors.mainBlue.ignoresSafeArea()
            VStack(spacing: 0) {
                
                UnderlineTextField(text: $cardPackTitle, wordType: "Add Title", language: "")
                    .padding(.horizontal)
                
                ScrollView() {
                    ForEach(flashCards.indices, id: \.self) { index in
                        CardComponent(
                            word: $flashCards[index].text,
                            definition: $flashCards[index].definition
                        )
                    }
                }
                
                
                VStack(spacing: 0) {
                    Divider()
                        .background(AppColors.shadowBlue)
                        .shadow(color: .black ,radius:3, y: -4)
                    
                    HStack {
                        Spacer()
                        Button(""){
                            //print(viewModel.cards)
                            flashCards.append(BindingFlashCard(text: "", definition: ""))
                        }.buttonStyle(CircleBigButtonViewComponent(icon: "+"))
                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                    .background(AppColors.mainBlue)
                }
                
            }
        }
        .toolbarBackground(AppColors.mainBlue, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss() // Dismiss the view
                }) {
                    HStack(spacing: 5) {
                        Text("+")
                            .rotationEffect(.degrees(45))
                            .title1Style()
                    }
                }
            }
            
            ToolbarItem(placement: .principal) { // Center-aligned title
                Text("Create card pack")
                    .title3Style() // Customize the color
                    .navigationBarTitleDisplayMode(.large)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("") {
                    cardPack.name = cardPackTitle
                    cardPack.cards = flashCards.map { .init(frontText: $0.text, backText: $0.definition, cardPack: cardPack) }
                    modelContext.insert(cardPack)
                    dismiss()
                }
                .buttonStyle(SquareSmallViewComponentButton(icon: "√", width: 33, height: 30))
                    
                
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}




#Preview {
    AddCardPackView()
}


struct BindingFlashCard: Identifiable {
    let id: UUID = UUID()
    var text: String
    var definition: String
}
