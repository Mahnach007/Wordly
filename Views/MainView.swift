import SwiftUI

struct MainView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach((0...50), id: \.self) { _ in
                    Button("") {
                        
                    }
                    .padding(1)
                    .buttonStyle(CardPackViewComponentButton(title: "Transport", count: 7))
                }
            }
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { // Center-aligned title
                    Text("Card Packs")
                        .title1Style() // Customize the color
                }
            }
            .padding()
            .background(AppColors.mainBlue) // Background for the scrollable area
            
            // Safe area inset for custom bottom button and divider
            .safeAreaInset(edge: .bottom) {
                VStack() {
                    Divider()
                        .background(AppColors.shadowBlue)
                        .shadow(color: .black ,radius:1, y: -1)
                        .padding(-22)
                    HStack {
                        Spacer()
                        NavigationLink {
                            CardComponent()
                        } label: {
                            Button(""){}.buttonStyle(SquareViewComponentButton(icon: "+"))
                        }
                        Spacer()
                    }
                    .padding(.top, -20)
                    .background(AppColors.mainBlue)
                }
            }
        }
    }
}

#Preview {
    MainView()
}
