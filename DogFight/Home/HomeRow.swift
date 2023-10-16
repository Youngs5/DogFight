//
//  HomeRow.swift
//  DogFight
//
//  Created by LJh on 2023/09/15.
//

import SwiftUI

struct HomeRow: View {
    @EnvironmentObject private var homeStore: HomeStore
    @State var post: Post
    
    var body: some View {
        NavigationLink {
            DebateView(post: post)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: HomeNameSpace.screenWidth - 30, height: HomeNameSpace.screenHeight * 0.3)
                    .foregroundColor(.listGrayColor)
                HStack {
                    Spacer()
                    VStack {
                        HStack {
                            Text("\(post.title)")
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                            Spacer()
                        }.padding([.leading, .bottom], 1)
                        HStack {
                            Text("\(post.content)")
                                .foregroundColor(.white)
                                .lineLimit(1)
                            Spacer()
                        }
                        
                        HStack {
                            Text("남은시간: \(Int(post.debateTime))시간")
                                .foregroundColor(.white)
                                .font(.system(size: 10))
                            Spacer()
                        }.padding(.leading, 1)
                    }.padding(.leading, 20)
                    
                    Spacer()
                    
                    AsyncImage(url: URL(string: post.imageNames[0])) {
                        image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: HomeNameSpace.screenWidth * 0.25, height: HomeNameSpace.screenHeight * 0.30)
                        
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(Circle())
                    .padding(.trailing, 10)
                    Spacer()
                }
                
            }.frame(width: HomeNameSpace.screenWidth - 30, height: HomeNameSpace.screenHeight * 0.2)
        }

        
    }
}
