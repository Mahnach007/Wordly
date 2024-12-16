import SwiftUI
import SwiftData

struct MainView: View {
    @State private var searchText = ""
    @State private var showAddCardPack = false
    
    
    @Environment(\.modelContext) private var modelContext
    @Query private var cardPacks: [CardPack]
    
    @Namespace private var namespace
    private let zoomID = UUID()
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.mainBlue.ignoresSafeArea()
                VStack(spacing: 0) {
                    
                    ScrollView {
                        ForEach(cardPacks, id: \.self) { cardPack in
                            CardPackViewComponent(
                                title: cardPack.name,
                                count: cardPack.cards.count,
                                onTap: {
                                    cardPack.cards.forEach { card in
                                        print(card.frontText)
                                        print(card.backText)
                                    }
                                },
                                onLongPress: {
                                    deleteCardPack(cardPack: cardPack)
                                }
                            ).padding(.horizontal, 10)
                            .padding(.top, 15)
                        }
                    }
                    //.searchable(text: $searchText)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) { // Center-aligned title
                            Text("Card Packs")
                                .title1Style() // Customize the color
                        }
                    }
                    .toolbarBackground(AppColors.mainBlue, for: .navigationBar)
                    .background(AppColors.mainBlue)
                    
                    VStack(spacing: 0) {
                        Divider()
                            .background(AppColors.shadowBlue)
                            .shadow(color: .black ,radius:3, y: -3)
                        
                        HStack {
                            Spacer()
                            Button(""){
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    showAddCardPack = true
                                }
                                
                            }
                            .buttonStyle(SquareBigViewComponentButton(icon: "+"))
                            .checkZoomTransition(id: zoomID, namespace: namespace)
                            Spacer()
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                        .background(AppColors.mainBlue)
                    }
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                .navigationDestination(isPresented: $showAddCardPack) {
                    AddCardPackView()
                        .withZoomTransition(id: zoomID, namespace: namespace)
                }
            }
        }
    }
    
    private func deleteCardPack(cardPack: CardPack) {
        modelContext.delete(cardPack) // Delete the specific cardPack
        do {
            try modelContext.save() // Save the changes to persist the deletion
        } catch {
            print("Error deleting CardPack: \(error)")
        }
    }
    
}

#Preview {
    MainView()
}
