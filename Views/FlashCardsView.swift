import SwiftUI
import SwiftData
import AVFoundation

struct FlashCardsView: View {
    @Environment(\.dismiss) private var dismiss
    var cardPack: CardPack
    
    @State private var currentCardIndex = 0
    @State private var offset = CGSize.zero
    @State private var flipped = false
    
    private var cardsToReview: [FlashCard] {
        cardPack.cards.filter { !$0.isMastered }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.mainBlue.ignoresSafeArea()
                VStack {
                    ZStack {
                        AppColors.mainBlue.ignoresSafeArea()
                        
                        if currentCardIndex < cardsToReview.count {
                            let currentCard = cardsToReview[currentCardIndex]
                            
                            FlashCardView(
                                frontText: currentCard.frontText,
                                backText: currentCard.backText,
                                isFlipped: flipped
                            )
                            .offset(x: offset.width, y: 0)
                            .rotationEffect(.degrees(Double(offset.width / 10)))
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        offset = gesture.translation
                                    }
                                    .onEnded { _ in
                                        if offset.width > 100 {
                                            handleSwipeRight(currentCard)
                                        } else if offset.width < -100 {
                                            handleSwipeLeft(currentCard)
                                        } else {
                                            resetCard()
                                        }
                                    }
                            )
                            .onTapGesture {
                                withAnimation {
                                    flipped.toggle()
                                }
                            }
                        } else {
                            VStack(spacing: 20) {
                                Text(cardsToReview.isEmpty ? "All cards mastered!" : "Review incomplete cards")
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                                Button("Restart Unmastered Cards") {
                                    resetReview()
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.orange)
                                
                                Button("Reset All Cards") {
                                    resetAllCards()
                                }
                                .buttonStyle(.bordered)
                                .tint(.blue)
                            }
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 5) {
                            Text("+")
                                .rotationEffect(.degrees(45))
                                .title1Style()
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("\(currentCardIndex)/\(cardsToReview.count)")
                        .title3Style()
                }
            }
        }
    }
    
    // MARK: - Swipe Handlers
    
    private func handleSwipeRight(_ card: FlashCard) {
        card.isMastered = true
        moveToNextCard()
    }

    private func handleSwipeLeft(_ card: FlashCard) {
        card.isMastered = false
        moveToNextCard()
    }

    private func moveToNextCard() {
        withAnimation {
            offset = .zero
            flipped = false
            currentCardIndex += 1
        }
    }

    private func resetCard() {
        withAnimation {
            offset = .zero
        }
    }

    private func resetReview() {
        currentCardIndex = 0
        flipped = false
    }

    private func resetAllCards() {
        currentCardIndex = 0
        flipped = false
        cardPack.cards.forEach { $0.isMastered = false }
    }
}





struct FlashCardView: View {
    
    private let synthesizer = AVSpeechSynthesizer()
    
    let frontText: String
    let backText: String
    var isFlipped: Bool
    
    var body: some View {
        ZStack {
            // Front view
            CardFrontView(text: frontText)
                .title1Style()
                .opacity(isFlipped ? 0.0 : 1.0) // Hide when flipped
            
            // Back view (rotated 180 degrees)
            CardBackView(text: backText)
                .title1Style()
                .rotation3DEffect(
                    .degrees(180),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(isFlipped ? 1.0 : 0.0) // Hide when not flipped
        }
        .frame(width: 300, height: 200)
        .background(AppColors.mainBlue)
        .cornerRadius(15)
        .shadow(radius: 5)
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.5
        )
        .scaleEffect(0.95) // Slightly scale down for better aesthetics
        .animation(.easeInOut(duration: 0.6), value: isFlipped)
        .overlay(
                    VStack {
                        Spacer()
                        Button(action: {
                            if !isFlipped {
                                speakWordEn(frontText)
                            } else {
                                speakWordIt(backText)
                            }
                        }) {
                            Image(systemName: "speaker.wave.2.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(AppColors.shadowBlue)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding(.bottom, 10)
                    }
                )
                .animation(.easeInOut(duration: 0.6), value: isFlipped)
    }
    
    private func speakWordEn(_ word: String) {
            let utterance = AVSpeechUtterance(string: word)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // Set language (English-US)
            utterance.rate = 0.5 // Adjust speech rate if needed
            synthesizer.speak(utterance)
        }
    
    private func speakWordIt(_ word: String) {
            let utterance = AVSpeechUtterance(string: word)
            utterance.voice = AVSpeechSynthesisVoice(language: "it") // Set language (English-US)
            utterance.rate = 0.5 // Adjust speech rate if needed
            synthesizer.speak(utterance)
        }

}


struct CardFrontView: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(AppColors.shadowBlue)
            Text(text)
                .font(.title)
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct CardBackView: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(AppColors.mainBlue)
            Text(text)
                .font(.title3)
                .foregroundColor(.white)
                .padding()
        }
    }
}


#Preview {
    
    FlashCardsView(cardPack: CardPack(name: ""))
}
