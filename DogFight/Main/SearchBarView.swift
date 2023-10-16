//
//  SearchBarView.swift
//  DogFight
//
//  Created by 방유빈 on 2023/09/15.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(hex: "#94949A"))
            TextField("", text: $text)
                .placeholder(when: text.isEmpty, placeholder: {
                    Text("Search messages")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#94949A"))
                })
        }
        .foregroundColor(.white)
        .padding(10)
        .background(LinearGradient(gradient: Gradient(colors: [Color.listGrayColor , Color.listGrayColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(20)
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""))
    }
}
