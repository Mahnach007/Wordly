//
//  CardPackViewComponent.swift
//  Wordly
//
//  Created by Vlad Gotovchykov on 10/12/24.
//

import SwiftUI

import SwiftUI

struct CardPackViewComponent: View {
    let title: String
    let count: Int
    let onTap: () -> Void
    let onLongPress: () -> Void

    @State private var isPressed: Bool = false
    private let offset = 5.0

    var body: some View {
        ZStack {
            // Background Shadow
            RoundedRectangle(cornerRadius: 7)
                .fill(AppColors.shadowBlue)
                .offset(y: offset)

            // Main Content with Press Behavior
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
            .offset(y: isPressed ? offset : 0)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 7)
                    .fill(AppColors.mainBlue)
                    .stroke(AppColors.shadowBlue, lineWidth: 2)
                    .offset(y: isPressed ? offset : 0)
            )
            .animation(.easeInOut(duration: 0.15), value: isPressed)
        }
        .contentShape(Rectangle()) // Ensure the entire row is tappable
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        isPressed = false
                    }
                    onTap()
                }
        )
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.5)
                .onEnded { _ in
                    onLongPress()
                }
        )
    }
}



struct SquareBigViewComponentButton: ButtonStyle {
    
    var icon: String
    let width: CGFloat
    let height: CGFloat
    
    
    init(
        icon: String,
        width: CGFloat = 53,
        height: CGFloat = 53
    ) {
        self.icon = icon
        self.width = width
        self.height = height
    }
    
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
                .offset(y: configuration.isPressed ? 0 : -5)
                
        }
        .frame(width: width, height: height) // Adjust frame size for a balanced look
    }
}

struct SquareSmallViewComponentButton: ButtonStyle {
    
    var icon: String
    let width: CGFloat
    let height: CGFloat
    
    
    init(
        icon: String,
        width: CGFloat = 53,
        height: CGFloat = 53
    ) {
        self.icon = icon
        self.width = width
        self.height = height
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let offset = 3.0
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
                .smallIconStyle() // Adjusted font size
                .foregroundColor(.white)
                .shadow(color: .white, radius: 3)
                .offset(y: configuration.isPressed ? 0 : -3)
                
        }
        .frame(width: width, height: height) // Adjust frame size for a balanced look
    }
}


struct CircleBigButtonViewComponent: ButtonStyle {
    
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

struct CircleSmallButtonViewComponent: ButtonStyle {
    
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
                .bodyStyle() // Adjusted font size
                .foregroundColor(.white)
                .shadow(color: .white, radius: 3)
                .offset(y: configuration.isPressed ? 0 : -4)
                
        }
        .frame(width: 53, height: 53) // Adjust frame size for a balanced look
    }
}


#Preview {
    CardPackViewComponent(title: "Button Styles", count: 5, onTap: {}) {}
    Button("Button") {
        
    }.buttonStyle(SquareBigViewComponentButton(icon: "+"))
    Button("Button") {
        
    }.buttonStyle(CircleBigButtonViewComponent(icon: "+"))
    
    Button("Button") {
        
    }.buttonStyle(SquareSmallViewComponentButton(icon: "√", width: 32,height: 30))

}
