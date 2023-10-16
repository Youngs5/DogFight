//
//  HomeView.swift
//  DogFight
//
//  Created by LJh on 2023/09/15.
//

import SwiftUI

enum HomeNameSpace {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.width
}

struct HomeView: View {
    @StateObject var homeStore: HomeStore = HomeStore()
    var body: some View {
            NavigationStack{
                if !homeStore.posts.isEmpty {
                    ZStack {
                        Color.backgrounBlack
                            .ignoresSafeArea()
                        ScrollView(showsIndicators: false) {
                            ForEach(homeStore.posts) { post in
                                HomeRow(post: post)
                                    .padding(30)
                            }
                            .padding(.bottom, 30)
                        }
                        .customToolbar()
                    }
                } else {
                    EmptyHomeView()
                }
            }.onAppear {
                homeStore.fetchPost()
            }
    }
}



