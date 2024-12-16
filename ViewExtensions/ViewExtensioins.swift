//
//  ViewExtensioins.swift
//  Wordly
//
//  Created by Vlad Gotovchykov on 15/12/24.
//

import Foundation
import SwiftUI

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .shadow(radius: 3, y: -4)
            .foregroundStyle(Color.white)
            .foregroundColor(AppColors.shadowBlue)
    }
    
    func withZoomTransition(id: UUID, namespace: Namespace.ID) -> some View {
        if #available(iOS 18.0, *) {
            return navigationTransition(.zoom(sourceID: id, in: namespace))
        } else {
            return self
        }
    }
    
    func checkZoomTransition(id: UUID, namespace: Namespace.ID) -> some View {
        if #available(iOS 18.0, *) {
            return matchedTransitionSource(id: id, in: namespace)
        } else {
            return self
        }
    }
}

