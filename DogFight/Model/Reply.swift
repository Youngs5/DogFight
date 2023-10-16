//
//  Reply.swift
//  DogFight
//
//  Created by 방유빈 on 2023/09/15.
//

import Foundation

struct Reply: Identifiable, Codable {
    var id: String = UUID().uuidString
    var postId: String
    var content: String
    var like: Int
    var createdAt: Double = Date().timeIntervalSince1970
    var createdDate: String {
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: dateCreatedAt)
    }
    var nickname: String
    var userImage: String
  
}
