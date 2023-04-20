//
//  ProductDetailsView.swift
//  LittleLemon
//
//  Created by David Esteban Hernández Garzón on 19/04/23.
//

import SwiftUI

struct ProductDetailsView: View {
    @ObservedObject var dish: Dish
    var body: some View {
        VStack(alignment: .leading) {
            Text(
                dish.title ?? "Unknown name"
            ).fontWeight(.bold)
                .font(
                    .custom(
                        LittleLemonFonts().karlaRegularFont,
                        size: 20
                    )
                ).foregroundColor(LittleLemonColors().Black)
                .padding(.horizontal, 16)
                
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    // Dish explanation
                    Text(dish.dishDescription ?? "No description found")
                        .font(.custom(LittleLemonFonts().karlaRegularFont, size: 16))
                        .foregroundColor(LittleLemonColors().DarkGray)
                        .lineLimit(2)
                        .padding(.bottom, 1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Dish price
                    Text("$\(dish.price ?? "0.0")")
                        .font(.custom("karlaRegularFont", size: 18))
                        .foregroundColor(LittleLemonColors().PrimaryLight)
                }
                if let imageUrl = dish.image {
                    if (imageUrl.isValidUrl()) {
                        if let imageUrl = URL(string: imageUrl) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipped()
                            } placeholder: {
                                // Placeholder image while the image is being downloaded
                                Color.gray
                                    .frame(width: 80, height: 80)
                            }
                        }
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 8)
            .padding(.leading, 16)
            .padding(.trailing, 8)
            Rectangle()
                .fill(LittleLemonColors().GrayTransparent.opacity(0.5))
                .frame(maxWidth: .infinity, maxHeight: 1)
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
    }
}
