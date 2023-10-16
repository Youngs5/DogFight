//
//  MainStore.swift
//  DogFight
//
//  Created by 방유빈 on 2023/09/16.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class MainStore: ObservableObject {
    @Published var debateList: [Post] = []
    @Published var randomList: [Post] = []
    @Published var categoryName: String = "All"
    @Published var searchText: String = ""
    
    private let db = Firestore.firestore()
    init() {}
    
    func fetchDebate() async throws {
        var tempList: [Post] = []
        let ref = db.collection("Debates")
        do {
            let snapshot = try await ref.getDocuments()
            let documents = snapshot.documents
            
            for document in documents {
                do {
                    let debate = try document.data(as: Post.self)
                    tempList.append(debate)
                } catch {
                    print(error)
                }
                self.debateList = tempList
            }
        } catch {
            print("Error when trying to encode book: \(error)")
        }
    }
    
    func getImageUrl(imageUrls: [String]) -> String {
        if imageUrls.isEmpty {
            return "https://www.ncenet.com/wp-content/uploads/2020/04/No-image-found.jpg"
        } else {
            return imageUrls[0]
        }
    }
    
    func filterCategoryList(){
        var tempList: [Post] = []
        switch categoryName {
        case "All":
            tempList = debateList
        case "Food" :
            tempList = debateList.filter { $0.category.title == "Food" }
        case "Sports":
            tempList = debateList.filter { $0.category.title == "Sport" }
        case "Animal":
            tempList = debateList.filter { $0.category.title == "Animal" }
        case "Stock":
            tempList = debateList.filter { $0.category.title == "Stocks" }
        case "Game":
            tempList = debateList.filter { $0.category.title == "Game" }
        case "etc":
            tempList = debateList.filter { $0.category.title == "etc" }
        default:
            tempList = debateList
        }
        randomList = tempList.shuffled()
     }
}
