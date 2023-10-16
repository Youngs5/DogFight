//
//  ButtonView.swift
//  DogFight
//
//  Created by 윤경환 on 2023/09/16.
//

import SwiftUI

struct ButtonView: View {
    @State private var alertMessage = ""
    @State private var isShowAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color.backgrounBlack
            
            VStack(spacing: 15) {
                Button {
                    alertMessage = "로그아웃 하시겠습니까?"
                    isShowAlert.toggle()
                } label: {
                    Text("로그아웃")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 44)
                        .background(Color.listGrayColor)
                        .cornerRadius(8)
                    
                }
                
                Button {
                    alertMessage = "정말 탈퇴 하시겠습니까?"
                    isShowAlert.toggle()
                } label: {
                    Text("회원탈퇴")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .frame(width: 350, height: 44)
                        .background(Color.listGrayColor)
                        .cornerRadius(8)
                    
                }
            }
            .background(Color.backgrounBlack)
            .alert(isPresented: $isShowAlert) {
                Alert(title: Text(""),
                      message: Text(alertMessage),
                      primaryButton: .destructive(Text("확인"),
                                                  action: {
                    if alertMessage == "로그아웃 하시겠습니까?" {
                        AuthService.shared.signOut()
                    } else if alertMessage == "정말 탈퇴 하시겠습니까?" {
                        AuthService.shared.deleteCurrentUser()
                    }}),
                      secondaryButton: .cancel(Text("취소")))
            }
        }
        .frame(height: 200)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
