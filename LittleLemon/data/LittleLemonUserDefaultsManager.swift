//
//  LittleLemonUserDefaultsManager.swift
//  LittleLemon
//
//  Created by David Esteban Hernández Garzón on 18/04/23.
//

import Foundation

class LittleLemonUserDefaultsManager {
    // Constants for key name values of the manager
    private let KEY_FIRST_NAME = "key_first_name"
    private let KEY_LAST_NAME = "key_last_name"
    private let KEY_EMAIL = "key_email"
    private let KEY_PHONE_NUMBER = "key_phone_number"
    private let KEY_EMAIL_NOTIFICATION_ORDER_STATUS = "key_email_notification_order_status"
    private let KEY_EMAIL_NOTIFICATION_PASSWORD_CHANGES = "key_email_notification_password_changes"
    private let KEY_EMAIL_NOTIFICATION_SPECIAL_OFFERS = "key_email_notification_special_offers"
    private let KEY_EMAIL_NOTIFICATION_NEWSLETTER = "key_email_notification_newsletter"
    
    // Instance of the user defaults
    private let defaults = UserDefaults.standard
    
    var firstName: String {
        get {
            return defaults.string(forKey: KEY_FIRST_NAME) ?? ""
        }
        set(value) {
            defaults.set(value, forKey: KEY_FIRST_NAME)
        }
    }
    
    var lastName: String {
        get {
            return defaults.string(forKey: KEY_LAST_NAME) ?? ""
        }
        set(value) {
            defaults.set(value, forKey: KEY_LAST_NAME)
        }
    }
    
    var email: String {
        get {
            return defaults.string(forKey: KEY_EMAIL) ?? ""
        }
        set(value) {
            defaults.set(value, forKey: KEY_EMAIL)
        }
    }
    
    var phoneNumber: String {
        get {
            return defaults.string(forKey: KEY_PHONE_NUMBER) ?? ""
        }
        set(value) {
            defaults.set(value, forKey: KEY_PHONE_NUMBER)
        }
    }
    
    var isEmailNotificationOrderStatusEnabled: Bool {
        get {
            return defaults.bool(forKey: KEY_EMAIL_NOTIFICATION_ORDER_STATUS)
        }
        set(value) {
            defaults.set(value, forKey: KEY_EMAIL_NOTIFICATION_ORDER_STATUS)
        }
    }
    
    var isEmailNotificationPasswordChangesEnabled: Bool {
        get {
            return defaults.bool(forKey: KEY_EMAIL_NOTIFICATION_PASSWORD_CHANGES)
        }
        set(value) {
            defaults.set(value, forKey: KEY_EMAIL_NOTIFICATION_PASSWORD_CHANGES)
        }
    }
    
    var isEmailNotificationSpecialOffersEnabled: Bool {
        get {
            return defaults.bool(forKey: KEY_EMAIL_NOTIFICATION_SPECIAL_OFFERS)
        }
        set(value) {
            defaults.set(value, forKey: KEY_EMAIL_NOTIFICATION_SPECIAL_OFFERS)
        }
    }
    
    var isEmailNotificationNewsletterEnabled: Bool {
        get {
            return defaults.bool(forKey: KEY_EMAIL_NOTIFICATION_NEWSLETTER)
        }
        set(value) {
            defaults.set(value, forKey: KEY_EMAIL_NOTIFICATION_NEWSLETTER)
        }
    }
    
    func saveLoginData(
        firstName: String = "",
        lastName: String = "",
        email: String = ""
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        isEmailNotificationOrderStatusEnabled = true
        isEmailNotificationPasswordChangesEnabled = true
        isEmailNotificationSpecialOffersEnabled = true
        isEmailNotificationNewsletterEnabled = true
    }
    
    func userIsLoggedIn() -> Bool {
        return !firstName.isEmpty &&
            !lastName.isEmpty &&
            !email.isEmpty &&
            email.isValidEmail()
    }
    
    func clearData() {
        firstName = ""
        lastName = ""
        email = ""
        phoneNumber = ""
    }
}
