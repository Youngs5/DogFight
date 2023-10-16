//
//  ToolBarModifier.swift
//  DogFight
//
//  Created by 방유빈 on 2023/09/18.
//

import Foundation
import SwiftUI

struct CustomToolbar: ViewModifier {
    @StateObject private var userService = UserService.shared

    public func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("DogFight")
                        .foregroundColor(.white)
                        .font(.custom("SigmarOne-Regular", size: 25))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if let user = userService.currentUser {
                        NavigationLink {
                            ProfileView()
                        } label: {
                            let url = user.profileImageUrl ?? "https://firebasestorage.googleapis.com/v0/b/dogfight-c9cc6.appspot.com/o/User%2FbasicImage.jpeg?alt=media&token=63d7151c-62bc-4af0-b216-7b6983c0fae8"
                            AsyncImage(url: URL(string: url)){ image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: UIScreen.main.bounds.width * 0.1)
                            } placeholder: {
                                EmptyView()
                            }
                            .padding(.horizontal, 10)
                        }
                    } else {
                        NavigationLink {
                            ProfileView()
                        } label: {
                            Text("Not found User")
                                .foregroundColor(.white)
                                .font(.caption)
                        }
                    }
                }
            }
//            .onAppear {
//                Task {
//                    do {
//                        if let user = try await UserService.shared.fetchCurrentUser() {
//                            self.user = user
//                        }
//                    } catch {
//                        print("사용자 정보를 로드하는 동안 오류 발생: \(error)")
//                    }
//                }
//            }

    }
}
