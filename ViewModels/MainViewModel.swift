//
//  MainViewModel.swift
//  Wordly
//
//  Created by Vlad Gotovchykov on 12/12/24.
//

import SwiftUI
import SwiftData


class MainViewModel: ObservableObject {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var cardPacks: [CardPack]
    
    init()
    {
        
    }
    
    func addCardPack(name: String) {
        let newItem = CardPack(name: name)
        modelContext.insert(newItem)
        try? modelContext.save()
    }
    
    func getAllCardPacks() -> [CardPack] {
        return cardPacks
    }
}
