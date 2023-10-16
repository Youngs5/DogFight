//
//  DebateView.swift
//  DogFight
//
//  Created by 신희권 on 2023/09/15.
//

import SwiftUI

struct DebateView: View {
    @EnvironmentObject var tabStore : TabStore
    @State var message: String = ""
    @State var isLike: Bool = false
    @State var isDisLike: Bool = false
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                
                TabView {
                    ForEach(1...3, id: \.self) { index in
                        AsyncImage(url: URL(string: "https://media.discordapp.net/attachments/1151868028036849815/1152145980377018398/image.png?width=1658&height=1137")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 200)
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                
                
                Rectangle()
                    .fill(.gray)
                    .frame(height: 100)
                    .overlay {
                        Text("이경영 VS 나선욱")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .cornerRadius(25)
                    .padding()
                
                HStack {
                    Button {
                        isLike.toggle()
                    } label: {
                        Image(systemName: isLike ? "hand.thumbsup.fill" : "hand.thumbsup")
                    }
                    Text("10")
                        .padding(.trailing, 20)
                    Button {
                        isDisLike.toggle()
                    } label: {
                        Image(systemName: isDisLike ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                    }
                    Text("20")
                    Spacer()
                }
                .foregroundColor(.white
                )
                .padding(.leading, 30)
                ForEach(1...5, id:\.self) { _ in
                    ReplyView()
                }
                
                TextField("댓글을 입력하세요", text: $message)
                
                    .overlay(alignment: .trailing) {
                        Button {
                            //
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.black)
                                .padding(10)
                        }
                        .buttonStyle(.plain)
                        
                    }
                    .background(.white)
                
                Spacer()
            }
            .toolbar(.hidden, for: .tabBar)
        }
        .onAppear{
            tabStore.isShowingTab = false
        }
        .onDisappear{
            tabStore.isShowingTab = true
        }
        
    }
}

struct DebateView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DebateView()
        }
    }
}
