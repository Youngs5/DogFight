//
//  User.swift
//  DogFight
//
//  Created by 방유빈 on 2023/09/15.
//

import Foundation

struct User: Identifiable,Codable {
    var id : String
    var email : String
    var password : String
    var lastName : String
    var firstName : String
    var phoneNumber : String
    var nickname : String
    var profileImageUrl : String?
    
    init(id: String, email: String, password: String, lastName: String, firstName: String, phoneNumber: String, nickname: String, profileImageUrl: String? = nil) {
        self.id = id
        self.email = email
        self.password = password
        self.lastName = lastName
        self.firstName = firstName
        self.phoneNumber = phoneNumber
        self.nickname = nickname
        self.profileImageUrl = profileImageUrl
    }
    
    init() {
        self.id = "id"
        self.email = "email"
        self.password = "password"
        self.lastName = "lastName"
        self.firstName = "firstName"
        self.phoneNumber = "phoneNumber"
        self.nickname = "nickname"
        self.profileImageUrl = "https://firebasestorage.googleapis.com/v0/b/dogfight-c9cc6.appspot.com/o/User%2FbasicImage.jpeg?alt=media&token=63d7151c-62bc-4af0-b216-7b6983c0fae8"
    }
}
