//
//  PromotedCard.swift
//  ShoppingCart
//
//  Created by George Nhari on 3/3/2022.
//

import SwiftUI

struct PromotedCard: View {
    
    var width: CGFloat
    @State private var showingSheet = false
    var product: Product
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            ZStack(alignment: .leading) {
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: 200)
                    .cornerRadius(20)
                    .brightness(-0.3)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 1) {
                    
                    Text(product.name)
                        .bold()
                        .font(Font.title)
                        .foregroundColor(backgroundColor3)
                        .shadow(color: blackBasic, radius: 2.5)
                        .offset(x: 20, y: -35)
                    
                    Text("Description of the thing")
                        .frame(alignment: .leading)
                        .foregroundColor(backgroundColor3)
                        .shadow(color: blackBasic, radius: 2.5)
                        .offset(x: 20, y: -25)
                    
                    
                }
            }
            ZStack(alignment: .topTrailing) {
                Text("-20%")
                    .foregroundColor(backgroundColor3)
                    .bold()
                    .padding(12)
                    .background(redAccent)
                    .cornerRadius(30, corners: [.bottomLeft, .topRight])

                    
            }
        }
        .sheet(isPresented: $showingSheet) {
            DetailScreen(product: product)
        }
        .onTapGesture {
            self.showingSheet.toggle()
        }
    }
}

struct PromotedCard_Previews: PreviewProvider {
    static var previews: some View {
        PromotedCard(width: 300, product: Product(name: "Strawberry", image: "fruit1", price: 4.99))
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
