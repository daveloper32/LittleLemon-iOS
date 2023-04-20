//
//  MenuItem.swift
//  LittleLemon
//
//  Created by David Esteban Hernández Garzón on 19/04/23.
//

import Foundation

struct MenuItem: Decodable {
    let id: Int
    let title: String
    let description: String
    let image: String
    let price: String
    let category: String
}
