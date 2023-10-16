//
//  AddDebateStore.swift
//  DogFight
//
//  Created by 오영석 on 2023/09/16.
//
import SwiftUI
import Firebase
import FirebaseStorage

class AddDebateStore: ObservableObject {
    @Published var debateTitle: String = ""
    @Published var selectedImages: [String] = []
    @Published var debateContent: String = ""
    let userService = UserService.shared
    
    func customPadding<Content: View>(_ content: Content) -> some View {
        content
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
    
    func registerDebate(debateTitle: String, debateContent: String, selectedCategory: Category, sliderValue: Double, selectedImages: [UIImage], completion: @escaping (Error?) -> Void) {
        guard let writerId = userService.currentUser?.id else {
            completion(NSError(domain: "유저 정보 에러", code: 1, userInfo: [NSLocalizedDescriptionKey: "로그인된 유저없음"]))
            
            return
        }
        
        uploadImages(selectedImages) { imageURLs, error in
            if let error = error {
                completion(error)
                
                return
            }
            
            guard let imageURLs = imageURLs else {
                completion(NSError(domain: "이미지 에러", code: 2, userInfo: [NSLocalizedDescriptionKey: "이미지 업로드 에러"]))
                
                return
            }
            
            
            
            let newDebate = Post(
                writerId: writerId,
                title: debateTitle,
                content: debateContent,
                imageNames: imageURLs,
                category: selectedCategory,
                debateTime: sliderValue,
                likeList: []
            )

            self.uploadDebateToFirestore(newDebate: newDebate) { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        }
    }

    
    func uploadImages(_ images: [UIImage], completion: @escaping ([String]?, Error?) -> Void) {
        var imageURLs: [String] = []
        var uploadedImageCount = 0
        
        for image in images {
            if let compressedImageData = image.jpegData(compressionQuality: 0.1) {
                let imageName = UUID().uuidString
                let imageRef = Storage.storage().reference().child("\(imageName).jpg")
                
                imageRef.putData(compressedImageData, metadata: nil) { (metadata, error) in
                    if let error = error {
                        completion(nil, error)
                        return
                    }
                    
                    imageRef.downloadURL { (url, error) in
                        if let error = error {
                            completion(nil, error)
                            return
                        }
                        
                        if let downloadURL = url {
                            imageURLs.append(downloadURL.absoluteString)
                            uploadedImageCount += 1
                            
                            if uploadedImageCount == images.count {
                                completion(imageURLs, nil)
                            }
                        }
                    }
                }
            }
        }
    }


    
    func uploadDebateToFirestore(newDebate: Post, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let debatesRef = db.collection("Debates")
        let documentRef = debatesRef.document(newDebate.id)

        documentRef.setData(newDebate.asDictionary()) { error in
            if let error = error {
                print("토론 정보 파이어베이스 추가 에러")
                completion(error)
            } else {
                print("토론 정보 파이어베이스 추가 성공")
                completion(nil)
            }
        }
    }
}
