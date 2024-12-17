
import SwiftUI
import SwiftData
import AVFoundation

struct FlashCardsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    var cardPack: CardPack
    
    @State private var currentCardIndex = 0 // Tracks the index of the current card
    @State private var offset = CGSize.zero // Tracks drag gesture offset
    @State private var flipped = false // Tracks flipped state for the current card
    
    @State private var learnedCardCount = 0
    @State private var reviewCardCount = 0
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.mainBlue.ignoresSafeArea()
                VStack {
                    HStack {
                        Text("\(reviewCardCount )").title3Style()
                        Spacer()
                        Text("\(learnedCardCount)").title3Style()
                    }
                    .padding(.horizontal)
                    .padding(.top, -30)
                    .background(AppColors.mainBlue)
                    
                    ZStack {
                        AppColors.mainBlue.ignoresSafeArea()
                        
                        if currentCardIndex < cardPack.cards.count {
                            let currentCard = cardPack.cards[currentCardIndex]
                            
                            FlashCardView(
                                frontText: currentCard.frontText,
                                backText: currentCard.backText,
                                isFlipped: flipped
                            )
                            .offset(x: offset.width, y: 0)
                            .rotationEffect(.degrees(Double(offset.width / 10))) // Add a tilt effect
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        offset = gesture.translation
                                    }
                                    .onEnded { _ in
                                        if offset.width > 100 {
                                            // Swiped right: learned word
                                            handleSwipeRight()
                                        } else if offset.width < -100 {
                                            // Swiped left: needs review
                                            handleSwipeLeft()
                                        } else {
                                            // Reset if not far enough
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
                            Text("You've reviewed all cards!")
                                .font(.title)
                                .foregroundColor(.white)
                            
                        }
                        
                    }
                    .navigationBarBackButtonHidden(true)
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
                        
                        ToolbarItem(placement: .principal) {
                            Text("\(currentCardIndex)/\(cardPack.cards.count)").title3Style()
                        }
                    }
                    
                }
            }
            
        
        }

    }
    
    // MARK: - Swipe Handlers
    
    private func handleSwipeRight() {
        // Move to next card: Word learned
        print("Card learned")
        learnedCardCount += 1
        moveToNextCard()
    }
    
    private func handleSwipeLeft() {
        // Move to next card: Needs review
        print("Needs review")
        reviewCardCount += 1
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
