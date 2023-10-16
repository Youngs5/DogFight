//
//  SignUpView.swift
//  DogFight
//
//  Created by 임대진 on 2023/09/17.
//

import SwiftUI

struct SignCustomAlert: View {
    
    @Binding var isPresented: Bool
    let title: String
    let content: String
    let primaryButtonTitle: String
    let primaryAction: () -> Void

    var body: some View {
      VStack(spacing: 20) {

        Text(title)
          .font(.title3)
          .bold()
          .foregroundColor(.signInWhite)
          .padding(.top, 10)

        Rectangle()
              .frame(height: 1)
              .foregroundColor(.signInWhite)

          VStack {
              
              Image("logo")
                  .resizable()
                  .scaledToFit()
                  .frame(height: 200)
                  .padding(.bottom, 10)
              
              Text(content)
                  .foregroundColor(.signInWhite)
                  .bold()
                  .font(.system(size: 20))
          }

        Button {
          primaryAction()
          isPresented = false
        } label: {
          Text(primaryButtonTitle)
            .foregroundColor(.signInWhite)
            .font(.title3)
            .bold()
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(Color.fieldGrayColor)
            .cornerRadius(10)
        }
        .buttonStyle(.borderless)
      }
      .padding(.horizontal, 24)
      .padding(.vertical, 18)
      .frame(width: 300)
      .background(
        RoundedRectangle(cornerRadius: 30)
          .stroke(Color.white.opacity(0.5))
          .background(
            RoundedRectangle(cornerRadius: 30)
              .fill(Color.backgrounBlack)
          )
      )
    }
  }

struct SignCustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        SignCustomAlert(isPresented: .constant(true), title: "회원 가입", content: "DAEJINLIM님 반갑습니다.", primaryButtonTitle: "들어가기", primaryAction: {})
    }
}
