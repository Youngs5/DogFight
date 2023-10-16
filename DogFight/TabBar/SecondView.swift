//
//  SecondView.swift
//  DogFight
//
//  Created by 김민기 on 2023/09/15.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        NavigationStack{
            NavigationLink {
                //DebateView()
            } label: {
                Text("zzz")
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
