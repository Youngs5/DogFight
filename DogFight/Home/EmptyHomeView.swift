//
//  EmptyHomeView.swift
//  DogFight
//
//  Created by 김민기 on 2023/09/15.
//

import SwiftUI

struct EmptyHomeView: View {
    var body: some View {
        NavigationStack{
            ZStack {
                Color.backgrounBlack.ignoresSafeArea()
                VStack{
                    Spacer()
                    VStack{
                        Text("Tap to start\na debate with\nothers")
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .foregroundColor(.white)
                        NavigationLink {
                            AddDebateView(addDebateStore: AddDebateStore())
                        } label: {
                            Image(systemName: "plus")
                                .font(.largeTitle)
                                .bold()
                                .frame(width: HomeNameSpace.screenWidth * 0.25,
                                       height: HomeNameSpace.screenWidth * 0.25)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.fieldGrayColor, style: .init(lineWidth: 3, lineCap: .round, dash: [10,10]))
                                }
                                .foregroundColor(.fieldGrayColor)
                        }
                    }.padding(.bottom,70)
                }
                .customToolbar()
            }
        }
    }
}

struct EmptyHomeView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyHomeView()
    }
}
