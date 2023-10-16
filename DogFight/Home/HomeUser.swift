//
//  HomeUser.swift
//  DogFight
//
//  Created by LJh on 2023/09/15.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

final class HomeStore: ObservableObject {
    @Published var posts: [Post] = []
    let dataBase =  Firestore.firestore().collection("Debates")
    let user = UserService.shared.currentUser
    
    init() {
    }
    func fetchPost() {
        self.posts.removeAll()
        if let user = AuthService.shared.userSession {
            
            let userId = user.uid
            
            dataBase.whereField("writerId", isEqualTo: userId).getDocuments { (document, error) in
                
                if let error = error {
                    print("Error fetching data: \(error)")
                } else {
                    for document in document!.documents {
                        if let postData = try? document.data(as: Post.self) {
                            self.posts.append(postData)
                        } else {
                            print("Error")
                        }
                    }
                }
            }
        } else {
            print("야옹야옹야옹야옹야옹야옹야옹야옹야옹야옹")
        }
        
        
    }
}


//let dummyHomeUser: [HomeUser] = [
//    HomeUser(email: "dasom8899@naver.com", password: "123", lastName: "JH", firstName: "L", phoneNumber: "01094863904", nickname: "이제빵", profileImageUrl: "https://talkimg.imbc.com/TVianUpload/tvian/TViews/image/2022/06/07/2feb35ef-ad93-400f-b7cd-0079db882cdd.jpg"),
//    HomeUser(email: "dasom8899@naver.com", password: "123", lastName: "JH", firstName: "L", phoneNumber: "01094863904", nickname: "이제빵", profileImageUrl: "https://talkimg.imbc.com/TVianUpload/tvian/TViews/image/2022/06/07/2feb35ef-ad93-400f-b7cd-0079db882cdd.jpg"),
//    HomeUser(email: "dasom8899@naver.com", password: "123", lastName: "JH", firstName: "L", phoneNumber: "01094863904", nickname: "이제빵", profileImageUrl: "https://talkimg.imbc.com/TVianUpload/tvian/TViews/image/2022/06/07/2feb35ef-ad93-400f-b7cd-0079db882cdd.jpg")
//]
//
//
//let dummyHomePost: [HomePost] = [
//    HomePost(writerId: "나선욱", title: "UserName", content: "아는형님에~ 아는친척에~ 아는 누님에~ 베이이~~~ ", imageUrl: "https://storage.enuri.info/pic_upload/knowbox2/202305/01493547720230513be14b7a6-0ca3-421d-a85f-e7abc65fee78.jpeg", category: "기타", likeCount: 0, disLikeCount: 0),
//    HomePost(writerId: "전소연", title: "UserName", content: "안녕하세요 전소연은 이뻐요 인정? 반박시 탈모", imageUrl: "https://talkimg.imbc.com/TVianUpload/tvian/TViews/image/2022/06/07/2feb35ef-ad93-400f-b7cd-0079db882cdd.jpg", category: "음식", likeCount: 0, disLikeCount: 0),
//    HomePost(writerId: "멈무", title: "UserName", content: "저 개는 하양일까? 투명일까?", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9JQXtDMPHZnD0bBgTODPgX_HmUZzlusBQ9kEPtkYwJg&s", category: "스포츠", likeCount: 0, disLikeCount: 0),
//]


