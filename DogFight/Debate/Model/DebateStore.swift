//
//  DebateStore.swift
//  DogFight
//
//  Created by 신희권 on 2023/09/15.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class DebateStore: ObservableObject {
    private let rdbRef = Database.database().reference().child("replys")
    private let fsRef = Firestore.firestore().collection("Debates")
    let user = UserService.shared.currentUser ?? User()
    @Published var replys: [Reply] = []
    @Published var post: Post = Post()
    
    final func upLoadReply(postId: String, content: String) {
        
        let reply = Reply(postId: postId, content: content, like: 0, nickname: user.nickname, userImage: user.profileImageUrl ?? "https://firebasestorage.googleapis.com/v0/b/dogfight-c9cc6.appspot.com/o/User%2FbasicImage.jpeg?alt=media&token=63d7151c-62bc-4af0-b216-7b6983c0fae8")
        do {
            let data = try JSONEncoder().encode(reply)
            let json = try JSONSerialization.jsonObject(with: data)
            
            rdbRef.child("\(post.id)/replys").child(reply.id).setValue(json) { (error, ref) in
                if let error = error {
                    print("Error sending message: \(error.localizedDescription)")
                } else {
                    print("Message sent successfully!")
                }
            }
        }
        catch {
            print("an error occurred", error)
        }
    }
    
    final func fetchReply(postid: String) async {
        rdbRef.child("\(postid)/replys").queryOrdered(byChild: "createdAt").observe(.value) { (snapshot) in
            self.replys = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    if let data = snapshot.value as? [String: Any],
                       let id = data["id"] as? String,
                       let postId = data["postId"] as? String,
                       let content = data["content"] as? String,
                       let like = data["like"] as? Int,
                       let createdAt = data["createdAt"] as? Double,
                       let nickname = data["nickname"] as? String,
                       let image = data["userImage"] as? String {
                        let reply = Reply(id: id, postId: postId, content: content, like: like,createdAt: createdAt, nickname: nickname, userImage: image)
                        self.replys.insert(reply, at: 0)
                    }
                    else {
                        print("error")
                    }
                }
                
            }
        }
    }
    
    final func removeReply(postId: String, replyId: String) {
        print("\(postId), \(replyId)")
           rdbRef.child("\(postId)/replys").child(replyId).removeValue { error, ref in
               if let error {
                   print("delete error\(error)")
               }
           }
       }
    final func checkLikeList() -> Bool {
        post.likeList.contains(user.id) ? true : false
    }
    
    final func updateLike(postId: String) {
        self.fetchPost(postId: postId)
        post.likeList.update(with: user.id)
        let arr = Array(post.likeList)
        fsRef.document(postId).updateData(["likeList" : arr]) { error in
            if let error {
                print(error)
            } else {
                print("success Update")
            }
        }
    }
    
    final func updateUnLike(postId: String) {
        self.fetchPost(postId: postId)
        post.likeList.remove(user.id)
        let arr = Array(post.likeList)
        fsRef.document(postId).updateData(["likeList" : arr]) { error in
            if let error {
                print(error)
            } else {
                print("success Update")
            }
        }
    }
    
    
    final func fetchPost(postId: String) {
        fsRef.whereField("id", isEqualTo: postId).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching post: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = querySnapshot else {
                print("No data available")
                return
            }
            
            for document in snapshot.documents {
                if let post = try? document.data(as: Post.self) {
                    self.post = post
                    print("Post updated")
                } else {
                    print("Error decoding Post data")
                }
            }
        }
    }
}

