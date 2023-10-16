//
//  ReplyView.swift
//  DogFight
//
//  Created by 신희권 on 2023/09/15.
//

import SwiftUI

struct ReplyView: View {
    var debateStore: DebateStore
    var postId: String
    var reply: Reply
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            AsyncImage(url: URL(string: reply.userImage)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .cornerRadius(50)
            VStack(alignment: .leading, spacing: 5) {
                HStack (spacing: 10){
                    if reply.nickname == UserService.shared.currentUser?.nickname ?? "" {
                        Text(reply.nickname)
                            .foregroundColor(.green)
                            .font(.headline)
                            .bold()
                    } else {
                        Text(reply.nickname)
                            .font(.headline)
                            .bold()
                    }
                    
                    Text(reply.createdDate)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Text(reply.content)
                    .font(.subheadline)
                
                Text(reply.like == 0 ? "" : "Like \(reply.like)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if reply.nickname == UserService.shared.currentUser?.nickname ?? "" {
                Button {
                    debateStore.removeReply(postId: postId, replyId: reply.id)
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
                .buttonStyle(.plain)
            }
            
        }
        
        .padding(5)
        .listRowBackground(Color.fieldGrayColor)
        .foregroundColor(.white)
        
    }
}

struct ReplyView_Previews: PreviewProvider {
    static var previews: some View {
        ReplyView(debateStore: DebateStore(), postId: "", reply: Reply(id: "", postId: "", content: "", like: 0, createdAt: 0, nickname: "", userImage: ""))
    }
}
