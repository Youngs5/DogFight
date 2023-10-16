//
//  SignUpView.swift
//  DogFight
//
//  Created by 임대진 on 2023/09/17.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

//사용자 서비스(로컬단의 세션)
class UserService: ObservableObject {
    @Published var currentUser: User?
    
    static let shared = UserService()
    init() {
            Task { try await fetchCurrentUser() }
        }
    //    UserService.shared.currentUser
    
    //현재 유저 패치작업
    @MainActor
        func fetchCurrentUser() async throws -> User? {
            guard let uid = Auth.auth().currentUser?.uid else {
                return nil
            }
            let snapshot = try await Firestore.firestore().collection("Users").document(uid).getDocument()
            
            let user = try snapshot.data(as: User.self)
            
            self.currentUser = user
            
//            print("로그인되었습니다 정보: \(user)")
            
            return user
        }
    
    //본인을 제외한 유저들고 오기
    @MainActor
    static func fetchUsers() async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await Firestore.firestore().collection("Users").getDocuments()
        let users = snapshot.documents.compactMap({try? $0.data(as: User.self) })
        return users.filter({ $0.id != currentUid })
    }
    
    
    //현재유저 삭제
    func reset() {
        self.currentUser = nil
    }
    
    
}



