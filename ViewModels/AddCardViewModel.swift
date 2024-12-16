//
//  AddCardViewModel.swift
//  Wordly
//
//  Created by Vlad Gotovchykov on 12/12/24.
//

import Foundation


class AddCardViewModel: ObservableObject {
    
    @Published var cards: [CardComponent] = []
    
    
    func addCard(_ card: CardComponent) {
        cards.append(card)
    }
}
