//
//  AddCardView.swift
//  Wordly
//
//  Created by Vlad Gotovchykov on 12/12/24.
//

import SwiftUI

struct AddCardView: View {
    var body: some View {
        VStack {
            ScrollView {
                CardComponent()
                CardComponent()
                CardComponent()
                CardComponent()
                CardComponent()
            }
            
        }
        .safeAreaInset(edge: .bottom) {
            VStack() {
                Divider()
                    .background(AppColors.shadowBlue)
                    .shadow(color: .black ,radius:1, y: -1)
                    .padding()
                HStack {
                    Spacer()
                    NavigationLink {
                        CardComponent()
                    } label: {
                        Button(""){}.buttonStyle(circleViewComponentButton(icon: "+"))
                    }
                    Spacer()
                }
                .padding(.top, -20)
                .background(AppColors.mainBlue)
            }
        }
    }
}

#Preview {
    AddCardView()
}
