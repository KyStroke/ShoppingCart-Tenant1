//
//  DetailScreen.swift
//  Furniture_app
//
//  Created by Abu Anwar MD Abdullah on 15/2/21.
//

import SwiftUI

struct DetailScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isAdded : Bool = false
    var product: Product
    @State var count: Int = 1
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        
        ZStack {
            
            ScrollView  {
                // Product Image
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.top)
                    .frame(width: UIScreen.main.bounds.size.width, height: 300)
                    .clipped()
                
                VStack (alignment: .leading) {
                    // Title
                    Text(product.name)
                        .font(Font.custom("SFProDisplay-Bold", size: 26))
                        .padding(.bottom, 20)
                        .frame(width: 200, alignment: .leading)
                    
                    Text("1 kg / $ \(product.price, specifier: "%.2f")")
                        .font(Font.custom("SFProDisplay-Semibold", size: 14))
                        .foregroundColor(blackBasic)
                        .padding(.bottom)
                        .brightness(0.3)
                    
                    Text("$ \(product.price + 10, specifier: "%.2f")")
                        .strikethrough(true)
                        .font(Font.custom("SFProDisplay-Semibold", size: 12))
                        .foregroundColor(darkGrayBasic)
                    
                    Text("$ \(product.price, specifier: "%.2f")")
                        .font(Font.custom("SFProDisplay-Bold", size: 24))
                        .foregroundColor(greenBasic)
                        .padding(.bottom, 3)
                    
                    Divider()
                    
                    VStack {
                        HStack(alignment: .center) {
                            Text("Expiration date")
                                .font(Font.custom("SFProDisplay-Bold", size: 14))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(blackBasic)
                            
                            Text(product.expirationDate)
                                .font(Font.custom("SFProDisplay-Bold", size: 14))
                                .foregroundColor(darkGrayBasic)
                        }
                        .padding(.bottom, 5)
                        
                        HStack(alignment: .center) {
                            Text("Country")
                                .font(Font.custom("SFProDisplay-Bold", size: 14))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(blackBasic)
                            
                            Text(product.country)
                                .font(Font.custom("SFProDisplay-Bold", size: 14))
                                .foregroundColor(darkGrayBasic)
                        }
                        .padding(.bottom, 5)
                        
                        HStack(alignment: .center) {
                            Text("Manufacturer")
                                .font(Font.custom("SFProDisplay-Bold", size: 14))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(blackBasic)
                            
                            Text("N/A")
                                .font(Font.custom("SFProDisplay-Bold", size: 14))
                                .foregroundColor(darkGrayBasic)
                        }
                        .padding(.bottom, 5)
                        
                        HStack(alignment: .center) {
                            Text("Storage conditions")
                                .font(Font.custom("SFProDisplay-Bold", size: 14))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(blackBasic)
                            
                            Text(product.storageConditions)
                                .font(Font.custom("SFProDisplay-Bold", size: 14))
                                .foregroundColor(darkGrayBasic)
                        }
                    }
                    
                    HStack(alignment: .bottom) {
                    }
                    Spacer(minLength: 40)
                }
                .padding()
                .padding(.top)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .offset(x: 0, y: -30.0)
                
            }
            .edgesIgnoringSafeArea(.top)
            
            HStack(alignment: .center) {
                
                if isAdded {
                    
                    Button(action: {
                        count = cartManager.removeQuantity(product: product)
                    }) {
                        Image(systemName: "minus")
                            .foregroundColor(darkGrayBasic)
                            .padding(.bottom, 20)
                            .padding(.top, 20)
                            .padding(.leading, 13)
                            .padding(.trailing, 13)
                            .background(backgroundColor1)
                            .cornerRadius(10.0)
                    }
                    
                    VStack(alignment: .center) {
                        Text("$ \(product.price * Double(count), specifier: "%.2f")")
                            .font(Font.custom("SFProDisplay-Bold", size: 20))
                            .foregroundColor(greenBasic)
                        Text("\(count)")
                            .font(Font.custom("SFProText-Light", size: 15))
                            .foregroundColor(darkGrayBasic)
                    }
                    .padding(.all, 5)
                    
                    Button(action: {
                        count = cartManager.incrQuantity(product: product)
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(darkGrayBasic)
                            .padding(.all, 13)
                            .background(backgroundColor1)
                            .cornerRadius(10.0)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    
                    isAdded.toggle()
                    if isAdded {
                        cartManager.addToCart(product: product)
                    } else {
                        
                        cartManager.removeFromCart(product: product)
                    }
                }) {
                    
                    Image(systemName: isAdded == true ? "checkmark" : "cart")
                        .padding(.leading, 12)
//                        .padding(.trailing, 0)
                        
                    Text( isAdded == true ?  "" : "Add to Cart")
                        .font(Font.custom("SFProDisplay-Regular", size: 14))
                        .foregroundColor(backgroundColor3)
                        .padding(.leading, 0)
                        .padding(.top, 12)
                        .padding(.bottom, 12)
                        .padding(.trailing,  isAdded == true ? 0 : 12)
                        .cornerRadius(10.0)
                    
                }
                .foregroundColor(backgroundColor3)
                .background(greenBasic)
                .cornerRadius(10.0)
                
            }
            .padding(.bottom, 16)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .background(backgroundColor3)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            count = cartManager.checkQuantity(product: product)
            isAdded = cartManager.checkIfCartState(product: product)
        }
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(product: Product(name: "Mixed Flavor", image: "13", price: 2.75, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"))
            .environmentObject(CartManager())
    }
}

struct ColorDotView: View {
    let color: Color
    var body: some View {
        color
            .frame(width: 24, height: 24)
            .clipShape(Circle())
    }
}


struct BackButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .foregroundColor(blackBasic)
                .padding(.all, 12)
                .background(backgroundColor3)
                .cornerRadius(8.0)
        }
    }
}
