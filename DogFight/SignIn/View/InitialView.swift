////
////  SignUpView.swift
////  DogFight
////
////  Created by 임대진 on 2023/09/17.
////
//
//import SwiftUI
//
//
//struct InitialView: View {
//    @StateObject private var initialViewStore = InitialViewStore()
//    @StateObject private var tabStore = TabStore()
//
//
//    var body: some View {
//        if initialViewStore.userSession != nil {
//                MainTabBarView()
//                    .environmentObject(tabStore)
//        } else {
//                SignInView()
//        }
//    }
//}
//
//struct InitialView_Previews: PreviewProvider {
//    static var previews: some View {
//        InitialView()
//    }
//}
