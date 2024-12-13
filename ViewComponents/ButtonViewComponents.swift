//
//  CardPackViewComponent.swift
//  Wordly
//
//  Created by Vlad Gotovchykov on 10/12/24.
//

import SwiftUI

struct CardPackViewComponentButton: ButtonStyle {
    let title: String
    let count: Int
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            
            let offset = 5.0
            
            HStack {
                Image(systemName: "lanyardcard.fill")
                    .font(.system(size: 45))
                    .padding(.leading, 10)
                VStack(alignment: .leading) {
                    Text(title)
                        .title3Style()
                    Text("Words: \(count)")
                        .bodyStyle()
                }
                Spacer()
            }
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity)
            .offset(y: configuration.isPressed ? offset : 0)
            .background(
                RoundedRectangle(cornerRadius: 7)
                    .fill(AppColors.mainBlue)
                    .stroke(AppColors.shadowBlue, lineWidth: 2)
                    .offset(y: configuration.isPressed ? offset : 0)
                    
            )
            .background(
                RoundedRectangle(cornerRadius: 7)
                    .fill(AppColors.shadowBlue)
                    .stroke(AppColors.shadowBlue, lineWidth: 2)
                    .offset(y: 5)
            )
        }
    }
}


struct SquareViewComponentButton: ButtonStyle {
    
    var icon: String
    
    func makeBody(configuration: Configuration) -> some View {
        let offset = 5.0
        ZStack {
            // Shadow Rectangle
            RoundedRectangle(cornerRadius: 7)
                .fill(AppColors.shadowGreen)
                .offset(y: offset)
            
            // Main Rectangle
            RoundedRectangle(cornerRadius: 7)
                .fill(AppColors.mainGreen)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(AppColors.shadowGreen, lineWidth: 2)
                )
                .offset(y: configuration.isPressed ? offset : 0)
            
            // Plus Symbol
            Text("\(icon)")
                .title1Style() // Adjusted font size
                .foregroundColor(.white)
                .shadow(color: .white, radius: 3)
                .offset(y: configuration.isPressed ? 0 : -4)
                
        }
        .frame(width: 53, height: 53) // Adjust frame size for a balanced look
    }
}

struct circleViewComponentButton: ButtonStyle {
    
    var icon: String
    
    func makeBody(configuration: Configuration) -> some View {
        let offset = 5.0
        ZStack {
            // Shadow Rectangle
            Circle()
                .fill(AppColors.shadowGreen)
                .offset(y: offset)
            
            // Main Rectangle
            Circle()
                .fill(AppColors.mainGreen)
                .offset(y: configuration.isPressed ? offset : 0)
            
            // Plus Symbol
            Text("\(icon)")
                .title1Style() // Adjusted font size
                .foregroundColor(.white)
                .shadow(color: .white, radius: 3)
                .offset(y: configuration.isPressed ? 0 : -4)
                
        }
        .frame(width: 53, height: 53) // Adjust frame size for a balanced look
    }
}


#Preview {
    Button("Button") {
        
    }.buttonStyle(CardPackViewComponentButton(title: "lj", count: 8))
    Button("Button") {
        
    }.buttonStyle(SquareViewComponentButton(icon: "+"))
    Button("Button") {
        
    }.buttonStyle(circleViewComponentButton(icon: "+"))

}
