//
//  Card.swift
//  Wordly
//
//  Created by Vlad Gotovchykov on 12/12/24.
//

import Foundation
import SwiftData

@Model
class FlashCard {
    @Attribute(.unique) var id: UUID
    var frontText: String // Text on the front of the card
    var backText: String // Text on the back of the card
    var isMastered: Bool // Whether the card is mastered
    //var lastReviewedAt: Date? // When the card was last reviewed
    @Relationship var cardPack: CardPack // Reference to parent CardPack

    init(frontText: String, backText: String, cardPack: CardPack, isMastered: Bool = false) {
        self.id = UUID()
        self.frontText = frontText
        self.backText = backText
        self.isMastered = isMastered
        //self.lastReviewedAt = nil
        self.cardPack = cardPack
    }
}



@Model
class CardPack {
    @Attribute(.unique) var id: UUID
    var name: String
    var cards: [FlashCard]
    //var language: String // Language of the card pack (e.g., "English")
    //var targetLanguage: String // Target language (e.g., "Italian")
    //var progress: Double? // Optional: Mastery progress (0.0 to 1.0)

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.cards = []
        //self.language = language
        //self.targetLanguage = targetLanguage
        //self.progress = 0.0
    }
}
