//
//  Utils.swift
//  LittleLemon
//
//  Created by David Esteban Hernández Garzón on 18/04/23.
//

import Foundation


extension String {
    func isValidEmail() -> Bool {
        let emailRegex = try! NSRegularExpression(pattern: "\\b[\\w.%-]+@[\\w.-]+\\.[A-Za-z]{2,}\\b")
        return emailRegex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidUrl() -> Bool {
        let urlPattern = #"^(http(s)?://)?([\w-]+\.)+[\w-]+(/[\w- ;,./?%&=]*)?$"#
        let regex = try! NSRegularExpression(pattern: urlPattern)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
