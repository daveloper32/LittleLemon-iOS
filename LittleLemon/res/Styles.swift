//
//  Styles.swift
//  LittleLemon
//
//  Created by David Esteban Hernández Garzón on 18/04/23.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(LittleLemonColors().Black)
            .background(
                configuration.isPressed ? LittleLemonColors().Secondary.opacity(0.8) : LittleLemonColors().Secondary
            )
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
            .stroke(
                LittleLemonColors().Tertiary, lineWidth: 1)
            )
            
    }
}

struct CustomButtonStyle2: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(LittleLemonColors().White)
            .background(
                configuration.isPressed ? LittleLemonColors().Primary.opacity(0.8) : LittleLemonColors().Primary
            )
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
            .stroke(
                LittleLemonColors().Primary, lineWidth: 1)
            )
            
    }
}

struct CustomButtonStyle3: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(LittleLemonColors().GrayLight)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
            .stroke(
                LittleLemonColors().Primary, lineWidth: 1)
            )
            
    }
}
