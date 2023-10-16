//
//  Post.swift
//  DogFight
//
//  Created by 방유빈 on 2023/09/15.
//

import Foundation

struct Post: Identifiable, Codable {
    var id: String = UUID().uuidString
    var writerId: String
    var title: String
    var content: String
    var imageNames: [String]
    var category: Category
    var debateTime: Double
    var likeList: Set<String>
    var likeCount: Int {
        likeList.count
    }
    
    init(writerId: String, title: String, content: String, imageNames: [String], category: Category, debateTime: Double, likeList: Set<String>) {
        self.writerId = writerId
        self.title = title
        self.content = content
        self.imageNames = imageNames
        self.category = category
        self.debateTime = debateTime
        self.likeList = likeList
    }
    
    init() {
        self.writerId = "writerId"
        self.title = "title"
        self.content = "content"
        self.imageNames = ["imageNames"]
        self.category = Category.list[0]
        self.debateTime = 0
        self.likeList = []
    }
}
