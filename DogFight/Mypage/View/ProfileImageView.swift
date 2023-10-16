//
//  ProfileImageView.swift
//  DogFight
//
//  Created by 윤경환 on 2023/09/18.
//

import SwiftUI

struct ProfileImageView: View {
    @EnvironmentObject private var myProfileStore: MyProfileStore
    @State var selectedImages: [UIImage] = []
    @State  var selectedImageNames: [String] = []
    @State private var isImagePickerPresented = false
    
    var body: some View {
        Button {
            isImagePickerPresented.toggle()
        } label: {
            ZStack {
                AsyncImage(url: URL(string: myProfileStore.myProfile.profileImageUrl ?? "https://firebasestorage.googleapis.com/v0/b/dogfight-c9cc6.appspot.com/o/User%2FbasicImage.jpeg?alt=media&token=63d7151c-62bc-4af0-b216-7b6983c0fae8")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: HomeNameSpace.screenWidth * 0.25,
                               height: HomeNameSpace.screenWidth * 0.25)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                    
                } placeholder: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.fieldGrayColor, style: .init(lineWidth: 3, lineCap: .round, dash: [10,10]))
                            .frame(width: HomeNameSpace.screenWidth * 0.25,
                                   height: HomeNameSpace.screenWidth * 0.25)
                        ProgressView()
                    }
                }
                .padding(.bottom, 30)
                
                VStack {
                    Image(systemName: "photo.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.gray)
                }
                .offset(x: 35, y: 30)
            }
        }.sheet(isPresented: $isImagePickerPresented) {
            if !selectedImages.isEmpty && !selectedImageNames.isEmpty {
                myProfileStore.uploadImage(image: selectedImages[0], name: selectedImageNames[0]) { result in
                    if result == true{
                        Task {
                            do {
                                try await myProfileStore.updateUserData()
                                try await UserService.shared.fetchCurrentUser()
                            } catch{
                                debugPrint("업로드에러")
                            }
                            
                        }
                    }
                }
                
            }
        } content: {
            MultiPhotoSelectView(selectedImages: $selectedImages, selectedImageNames: $selectedImageNames)
        }
    }
}
    struct ProfileImageView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileImageView(selectedImages: [], selectedImageNames: [])
                .environmentObject(MyProfileStore())
        }
    }
