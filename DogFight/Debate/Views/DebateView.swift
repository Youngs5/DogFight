//
//  DebateView.swift
//  DogFight
//
//  Created by 신희권 on 2023/09/15.
//

import SwiftUI
/* TODO: -
 
 */
struct DebateView: View {
    @StateObject var debateStore = DebateStore()
    @EnvironmentObject private var tabStore: TabStore
    @State private var message: String = ""
    @State private var isShowingReplySheet: Bool = false
    @State private var isLike: Bool = false
    var post: Post
    var body: some View {
        ZStack {
            
            Color.backgrounBlack
                .ignoresSafeArea()
            
            VStack {
                
                TabView {
                    ForEach(debateStore.post.imageNames, id: \.self) { myImage in
                        AsyncImage(url: URL(string: myImage)) { image in
                            image.resizable()
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 230)
                        .tag(myImage)
                    }
                }
                .frame(height: 230)
                .padding(.horizontal, 10)
                .cornerRadius(8)
                .tabViewStyle(PageTabViewStyle())
                
                
                Rectangle()
                    .fill(Color.fieldGrayColor)
                    .frame(height: 130)
                    .overlay {
                        Text(debateStore.post.content)
                            .font(.title3)
                            .foregroundColor(.white)
                            .bold()
                    }
                    .cornerRadius(5)
                    .padding(10)
                
                HStack{
                    Button {
                        if debateStore.checkLikeList() {
                            debateStore.updateUnLike(postId: post.id)
                        } else {
                            debateStore.updateLike(postId: post.id)
                        }
                        isLike.toggle()
                    } label: {
                        Image(systemName: debateStore.checkLikeList() ? "hand.thumbsup.fill" : "hand.thumbsup")
                    }
                    Text("\(debateStore.post.likeCount)")
                        .padding(.trailing, 20)
                    
                    Spacer()
                    if debateStore.replys.count > 1 {
                        Button {
                            isShowingReplySheet = true
                        } label: {
                            Text("댓글 더보기")
                        }
                    }
                }
                .padding(.horizontal, 20)
                if !debateStore.replys.isEmpty {
                    withAnimation {

                        ScrollViewReader { scroll in
                            List(debateStore.replys) { reply in
                                ReplyView(debateStore: debateStore, postId: post.id, reply: reply)
                                    .id(reply.id)
                            }
                            
                            .listStyle(.plain)
                            .background(Color.listGrayColor)
                            .onChange(of: debateStore.replys.count) { _ in
                                withAnimation {
                                    scroll.scrollTo(debateStore.replys.first?.id, anchor: .top)
                                }
                            }
                        }.cornerRadius(5)
                        
                    }.padding(10)
                    
                }
                
                Spacer()
                Rectangle()
                    .fill(Color.fieldGrayColor)
                    .overlay {
                        TextField("댓글을 입력하세요", text: $message)
                            .padding(10)
                    }
                    .overlay(alignment: .trailing) {
                        Button {
                            withAnimation {
                                if !message.isEmpty {
                                    debateStore.upLoadReply(postId: post.id, content: message)
                                    message = ""
                                }
                            }
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                                .padding(10)
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(height: 40)
                    .background(.white)
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 10)
                
                Spacer()
            }
            
        }
        .toolbar(content: {
            ToolbarItem {
                Text("\(debateStore.post.title)")
                    .font(.custom("SigmarOne-Regular", size: UIScreen.main.bounds.width * 0.07))
                    .bold()
                    .foregroundColor(Color.white)
                    .padding(.bottom, 10)
            }
        })
        .task {
            debateStore.fetchPost(postId: post.id)
            await debateStore.fetchReply(postid: post.id)
        }
        .sheet(isPresented: $isShowingReplySheet) {
            ReplyDetailView(debateStore: debateStore, postId: post.id, isShowingSheet: $isShowingReplySheet)
        }
        .foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for:.tabBar)
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
            DebateView(post: Post())
                .environmentObject(TabStore())
        }
    }
}
