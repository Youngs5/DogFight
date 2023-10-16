//
//  Category.swift
//  DogFight
//
//  Created by 방유빈 on 2023/09/15.
//

import Foundation

struct Category: Identifiable, Codable {
    var id = UUID().uuidString
    let title: String
}

extension Category {
    static let list: [Category] = [
        Category(title: "Food"),
        Category(title: "Sport"),
        Category(title: "Animal"),
        Category(title: "Stocks"),
        Category(title: "Game"),
        Category(title: "etc"),
    ]
}
