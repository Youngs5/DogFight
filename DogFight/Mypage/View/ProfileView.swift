//
//  ProfileView.swift
//  DogFight
//
//  Created by 윤경환 on 2023/09/15.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var myProfileStore: MyProfileStore
    @EnvironmentObject private var tabStore: TabStore
    
    var body: some View {
        ZStack {
            Color.backgrounBlack
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "delete.backward")
                            .foregroundColor(Color.signInWhite)
                    }
                    Spacer()
                    Text("MYPAGE")
                        .font(.custom("SigmarOne-Regular", size: UIScreen.main.bounds.width * 0.07))
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(.trailing, 20)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                ProfileImageView()
                
                Form {
                    Group {
                        NavigationLink {
                            MyProfileChangeView(editType: .name)
                                .navigationBarBackButtonHidden()
                                .environmentObject(tabStore)
                        } label: {
                            HStack {
                                Text("이름")
                                    .fontWeight(.semibold)
                                Text(myProfileStore.myProfile.lastName + myProfileStore.myProfile.firstName)
                                    .foregroundColor(Color.gray)
                                    .padding([.leading, .trailing,], 30)
                            }
                        }
                        
                        NavigationLink {
                            MyProfileChangeView(editType: .phoneNumber)
                                .navigationBarBackButtonHidden()
                                .environmentObject(tabStore)
                        } label: {
                            HStack {
                                Text("연락처")
                                    .fontWeight(.semibold)
                                Text(myProfileStore.myProfile.phoneNumber)
                                    .foregroundColor(Color.gray)
                                    .padding([.leading, .trailing,])
                            }
                        }
                        
                        NavigationLink {
                            MyProfileChangeView(editType: .email)
                                .navigationBarBackButtonHidden()
                                .environmentObject(tabStore)
                        } label: {
                            HStack {
                                Text("이메일")
                                    .fontWeight(.semibold)
                                Text(myProfileStore.myProfile.email)
                                    .foregroundColor(Color.gray)
                                    .padding([.leading, .trailing,])
                            }
                        }
                        
                        NavigationLink {
                            MyProfileChangeView(editType: .nickname)
                                .navigationBarBackButtonHidden()
                                .environmentObject(tabStore)
                        } label: {
                            HStack {
                                Text("닉네임")
                                    .fontWeight(.semibold)
                                Text(myProfileStore.myProfile.nickname)
                                    .foregroundColor(Color.gray)
                                    .padding([.leading, .trailing,])
                            }
                        }
                    }
                    .listRowBackground(Color.listGrayColor)
                    .foregroundColor(Color.white)
                }
                .padding(.top, -30)
                .scrollContentBackground(.hidden)
                .navigationBarBackButtonHidden(true)
                .background(Color.backgrounBlack)
                ButtonView()
            }
            .toolbar(.hidden, for:.tabBar)
            .onAppear {
                tabStore.isShowingTab = false
                Task {
                    await myProfileStore.fetchUser()
                }
            }
            .onDisappear{
                tabStore.isShowingTab = true
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
                .environmentObject(MyProfileStore())
                .environmentObject(TabStore())
        }
    }
}

