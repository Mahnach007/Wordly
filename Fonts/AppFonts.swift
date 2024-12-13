//
//  AppFonts.swift
//  Wordly
//
//  Created by Vlad Gotovchykov on 10/12/24.
//


import SwiftUI

struct AppFonts {
    static let title1: Font = .custom("feather", size: 34)
    static let title3: Font = .custom("feather", size: 17)
    static let body1: Font = .custom("feather", size: 12)
}



struct AppColors {
    static let title1 = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    static let body1 = Color(#colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1))
    static let mainBlue: Color = Color(#colorLiteral(red: 0, green: 0.4705882353, blue: 0.8156862745, alpha: 1))
    static let shadowBlue: Color = Color(#colorLiteral(red: 0.08235294118, green: 0.2117647059, blue: 0.3803921569, alpha: 1))
    static let mainGreen: Color = Color(#colorLiteral(red: 0.3450980392, green: 0.8, blue: 0.007843137255, alpha: 1))
    static let shadowGreen: Color = Color(#colorLiteral(red: 0.2823529412, green: 0.462745098, blue: 0.05098039216, alpha: 1))
    static let buttonColor: Color = Color(#colorLiteral(red: 1, green: 0.7607843137, blue: 0, alpha: 1))

}

struct TextAndColorModifier: ViewModifier {
    let font: Font
    let color: Color
    
    func body(content: Content) -> some View {
        content.font(font).foregroundStyle(color)
    }
}

extension View {
    func title3Style() -> some View {
        modifier(TextAndColorModifier(font: AppFonts.title3, color: AppColors.title1))
    }
    
    func title1Style() -> some View {
        modifier(TextAndColorModifier(font: AppFonts.title1, color: AppColors.title1))
    }
    
    func bodyStyle() -> some View {
        modifier(TextAndColorModifier(font: AppFonts.body1, color: AppColors.body1))
    }
    
    func buttonStyle() -> some View {
        modifier(TextAndColorModifier(font: AppFonts.body1, color: AppColors.buttonColor))
    }
}
