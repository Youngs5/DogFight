//
//  SignUpView.swift
//  DogFight
//
//  Created by 임대진 on 2023/09/17.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

//파이어베이스의 인증 세션(서버단의 세션)
class AuthService: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    //singleton Pattern
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    let basicImage: String = "https://firebasestorage.googleapis.com/v0/b/dogfight-c9cc6.appspot.com/o/User%2FbasicImage.jpeg?alt=media&token=63d7151c-62bc-4af0-b216-7b6983c0fae8"
    @MainActor
    func login(withEmail email: String, password: String) async throws -> (Bool, String) {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
            
            self.userSession = result.user
            try await UserService.shared.fetchCurrentUser()
            return (result : true, message : "로그인 성공.")
        } catch {
            print("debug : Failed to Login In with \(error.localizedDescription)")
            print(String(describing: error))
            return (result : true, message : "이메일 또는 비밀번호가 다릅니다.")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, nickname: String, firstName: String, lastName: String, phoneNumber: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(id: result.user.uid, withEmail: email,password: password, nickname: nickname, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, profileImageUrl: basicImage)
            print("debug : Create User \(result.user.uid)")
        } catch {print(String(describing: error))
            print("debug : Failed to Create User with \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut() // 백엔드 ( 서버에서 로그아웃 )
        self.userSession = nil // 앱에서 세션을 제거하고 라우팅 업데이트
        UserService.shared.reset() // sets current User -> nil
    }
    
    private func uploadUserData(id: String, withEmail email: String, password : String, nickname: String, firstName: String, lastName: String, phoneNumber : String, profileImageUrl: String
    ) async throws {
        let user = User(id: id, email: email, password: password, lastName: lastName, firstName: firstName, phoneNumber: phoneNumber, nickname: nickname, profileImageUrl: profileImageUrl)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("Users").document(id).setData(userData)
        UserService.shared.currentUser = user
    }
//    func deleteCurrentUser() {
//        if let user = Auth.auth().currentUser {
//            user.delete { error in
//                if let error = error {
//                    print("사용자 삭제 중 오류 발생: \(error.localizedDescription)")
//                } else {
//                    print("사용자 삭제 완료")
//                    do {
//                        try Auth.auth().signOut()
//                        UserService.shared.currentUser = nil
//                    } catch {
//                        print("로그아웃 중 오류 발생: \(error.localizedDescription)")
//                    }
//                }
//            }
//        } else {
//            print("현재 로그인된 사용자가 없습니다.")
//        }
//    }
    func deleteCurrentUser() {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            
            db.collection("Users").document(user.uid).delete { error in
                if let error = error {
                    print("Firestore에서 사용자 데이터 삭제 중 오류 발생: \(error.localizedDescription)")
                } else {
                    print("Firestore에서 사용자 데이터 삭제 완료")
                    user.delete { authError in
                        if let authError = authError {
                            print("Firebase Authentication 사용자 삭제 중 오류 발생: \(authError.localizedDescription)")
                        } else {
                            print("Firebase Authentication 사용자 삭제 완료")
                            AuthService.shared.signOut()
                        }
                    }
                }
            }
        } else {
            print("현재 로그인된 사용자가 없습니다.")
        }
    }
}
