//
//  WordlyApp.swift
//  Wordly
//
//  Created by Vlad Gotovchykov on 10/12/24.
//

import SwiftUI
import SwiftData
@main
struct WordlyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [FlashCard.self, CardPack.self])
    }
}
