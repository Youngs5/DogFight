//
//  ReplyDetailView.swift
//  DogFight
//
//  Created by 신희권 on 2023/09/17.
//

import SwiftUI

struct ReplyDetailView: View {
    var debateStore: DebateStore
    var postId: String
    @Binding var isShowingSheet: Bool
    var body: some View {
        NavigationStack {
            ScrollViewReader { scroll in
                List(debateStore.replys) { reply in
                    ReplyView(debateStore: debateStore, postId: postId, reply: reply)
                        .id(reply.id)
                }
                .listStyle(.plain)
                .background(Color.listGrayColor)
                .onChange(of: debateStore.replys.count) { _ in
                    withAnimation {
                        scroll.scrollTo(debateStore.replys.first?.id, anchor: .top)
                    }
                }
            }
            .refreshable {
                
                Task {
                    await debateStore.fetchReply(postid: postId)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("닫기") { isShowingSheet = false }
                }
            }
        }
    }
}


struct ReplyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReplyDetailView(debateStore: DebateStore(),postId: "", isShowingSheet: .constant(true))
    }
}
