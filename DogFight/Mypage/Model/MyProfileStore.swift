//
//  MyProfileStore.swift
//  DogFight
//
//  Created by 윤경환 on 2023/09/16.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import FirebaseStorage

enum EditType: CaseIterable {
    case name
    case phoneNumber
    case email
    case nickname
    
    var name: String {
        switch self {
        case .name:
            return "이름"
        case .phoneNumber:
            return "연락처"
        case .email:
            return "이메일"
        case .nickname:
            return "닉네임"
        }
    }
}

final class MyProfileStore: ObservableObject {
    @Published var myProfile: User = User(id: "", email: "", password: "", lastName: "", firstName: "", phoneNumber: "", nickname: "")
    @Published var myupdateProfile: User = User(id: "", email: "", password: "", lastName: "", firstName: "", phoneNumber: "", nickname: "")
    @Published var editType: EditType = .name
    var isButtonDisabled: Bool {
        switch editType {
        case .name:
            return myProfile.firstName.isEmpty
        case .phoneNumber:
            return myProfile.phoneNumber.isEmpty
        case .email:
            return myProfile.email.isEmpty
        case .nickname:
            return myProfile.nickname.isEmpty
        }
    }
    
    let dataBase = Firestore.firestore().collection("Users")
    func fetchUser() async {
        do {
            guard let userSession = UserService.shared.currentUser
            else {
                return
            }
            
            let tempString: String = userSession.id
            print(tempString)
            dataBase.whereField("id", isEqualTo: tempString).getDocuments { (document, error) in
                if let error = error {
                    print("Error fetching data: \(error)")
                } else {
                    for document in document!.documents {
                        if let myProfile = try? document.data(as: User.self) {
                            self.myProfile = myProfile
                            self.myupdateProfile = myProfile
                        } else {
                            print("Error")
                        }
                    }
                }
            }
        } catch {
            print("error")
        }
    }
    
    func updateUserImage(image:UIImage, name: String) {
        print(name)
        print(image)
    }
    
    func uploadImage(image:UIImage, name: String, completion: @escaping (Bool?) -> Void) {
        guard image.cgImage != nil else {
            completion(nil)
            return
        }
        let storageRef = Storage.storage().reference()
        guard let userSession = UserService.shared.currentUser
        else {
            return
        }
        
        let tempString: String = userSession.id
        let imageRef = storageRef.child("userImage").child(tempString)
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
        _ = imageRef.putData(imageData, metadata: nil) { [weak self] (metadata, error) in
            guard let metadata = metadata else {
                // TODO: 에러 처리
                return
            }
            
            let size = metadata.size
            print(size)
            
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // 에러처리
                    completion(nil)
                    return
                }
                self?.myupdateProfile.profileImageUrl = downloadURL.absoluteString
                completion(true)
                print(downloadURL.absoluteString)
            }
        }
    }
    
    func updateUserData() async throws {
        guard let userData = try? Firestore.Encoder().encode(myupdateProfile) else { return }
        try await Firestore.firestore().collection("Users").document(myProfile.id).updateData(userData)
        await fetchUser()
    }
    
    func updateData(newValue: [String]) async {
        do {
            guard let user = UserService.shared.currentUser else { return }
            switch editType {
            case .name:
                try await dataBase.document(user.id).updateData(["firstName" : newValue[0], "lastName" : newValue[1]])
            case .phoneNumber:
                try await dataBase.document(user.id).updateData(["phoneNumber" : newValue[0]])
            case .email:
                try await dataBase.document(user.id).updateData(["email" : newValue[0]])
            case .nickname:
                try await dataBase.document(user.id).updateData(["nickname" : newValue[0]])
            }
            
        } catch {
            print(error)
        }
    }
    
}

//        for image in images {
//            if let compressedImageData = image.jpegData(compressionQuality: 0.1) {
//                let imageName = UUID().uuidString
//                let imageRef = Storage.storage().reference().child("\(imageName).jpg")
//
//                imageRef.putData(compressedImageData, metadata: nil) { (metadata, error) in
//                    if let error = error {
//                        completion(nil, error)
//                        return
//                    }
//
//                    imageRef.downloadURL { (url, error) in
//                        if let error = error {
//                            completion(nil, error)
//                            return
//                        }
//
//                        if let downloadURL = url {
//                            imageURLs.append(downloadURL.absoluteString)
//                            uploadedImageCount += 1
//
//                            if uploadedImageCount == images.count {
//                                completion(imageURLs, nil)
//                            }
//                        }
//                    }
//                }
//            }
//        }


//    static func fetchUserData() async throws -> MyProfileModel? {
//        do {
//            let myProfile: MyProfileModel = try await service.fetchDocument(collectionId: .User, documentId: UserService.shared.currentUser.id)
//            return myProfile
//        } catch {
//            return nil
//        }
//    }

