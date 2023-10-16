//
//  MainView.swift
//  DogFight
//
//  Created by 방유빈 on 2023/09/15.
//

import SwiftUI

struct MainView: View {
    @StateObject private var mainStore: MainStore = MainStore()
    @State private var text: String = ""
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var list: [Post] {
        if text.isEmpty {
            if mainStore.randomList.count > 7 {
                return Array(mainStore.randomList[0...7])
            }
            return mainStore.randomList
        } else {
            return mainStore.randomList.filter({ $0.title.localizedStandardContains(text)})
        }
    }
    var body: some View {
        NavigationStack{
            ZStack {
                Color.backgrounBlack.ignoresSafeArea()
                VStack{
                    SearchBarView(text: $text)
                        .padding(.bottom)
                    CategoryScrollView(mainStore: mainStore)
                        .padding(.bottom, 40)
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 30) {
                            NavigationLink {
                                AddDebateView(addDebateStore: AddDebateStore())
                            } label: {
                                VStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke(Color.fieldGrayColor, style: .init(lineWidth: 3, lineCap: .round, dash: [10,10]))
                                            .frame(width: HomeNameSpace.screenWidth * 0.25 - 3,
                                                   height: HomeNameSpace.screenWidth * 0.25 - 3)
                                        Image(systemName: "plus")
                                            .font(.largeTitle)
                                            .bold()
                                    }
                                    .foregroundColor(.fieldGrayColor)
                                    Text("ADD")
                                        .categoryStyle(background: .backgrounBlack, foreground: .backgrounBlack)
                                }
                            }
                            
                            ForEach(list) { post in
                                NavigationLink {
                                    DebateView(post: post)
                                } label: {
                                    VStack {
                                        AsyncImage(url: URL(string: mainStore.getImageUrl(imageUrls: post.imageNames))) { image in
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
                                        Text(post.title)
                                            .categoryStyle(background: Color.fieldGrayColor, foreground: .white)
                                            .lineLimit(1)
                                    }
                                }
                                
                            }
                        }
                    }
                    .refreshable {
                        Task {
                            try await mainStore.fetchDebate()
                            mainStore.filterCategoryList()
                        }
                    }
                }
                .padding()
            }
            .customToolbar()
        }
        .onAppear {
            Task {
                try await mainStore.fetchDebate()
                mainStore.filterCategoryList()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainView()
        }
    }
}
