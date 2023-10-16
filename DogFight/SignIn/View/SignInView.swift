//
//  SignInView.swift
//  DogFight
//
//  Created by 임대진 on 2023/09/15.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var emailErrorMessage: String = ""
    @State private var password: String = ""
    @State private var passwordErrorMessage: String = ""
    @State private var showAlert = false
    @State private var showSignInAlert = false
    @State private var alertMessage = ""
    @State private var isShowAlert: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
//                Color.backgrounBlack
                VStack{
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                    Text("DOGFIGHT")
                        .font(.custom("SigmarOne-Regular", size: UIScreen.main.bounds.width * 0.15))
                        .frame(height: 150)
                        .foregroundColor(.signInWhite)
                        .bold()
                    VStack(alignment: .leading) {
                        SignCustomTextField(placeholder: "EMAIL", keyboardType: .emailAddress, text: $email)
                        //                    Text("이메일 형식이 올바르지 않습니다.")
                        //                        .foregroundColor(.red)
                        SignCustomSecureField(placeholder: "PASSWORD", text: $password)
                    }
                    .padding(.horizontal, 20)
                    
                    VStack {
                        Button {
                            if email.isEmpty {
                                showAlert = true
                                alertMessage = "이메일을 입력해주세요."
                            } else if !ValidationUtility.isValidEmail(email) {
                                showAlert = true
                                alertMessage = "이메일 형식이 올바르지 않습니다."
                            } else if password.count < 6 {
                                showAlert = true
                                alertMessage = "비밀번호는 6자리 이상이어야 합니다."
                            } else {
                                Task {
                                    let loginResult : (result : Bool, message: String) = try await AuthService.shared.login(withEmail:email, password:password)
                                    showAlert = loginResult.result
                                    alertMessage = loginResult.message
                                }
                            }
                        } label: {
                            Text("SIGN  IN")
                        }
                        NavigationLink {
                            SignUpView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            Text("SIGN UP")
                        }
                    }
                    .font(.custom("SigmarOne-Regular", size: 30))
                    .foregroundColor(.signInWhite)
                    .padding(.top, 50)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.backgrounBlack)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .modifier(
                SignCustomAlertModifier(
                    isPresented: $showAlert,
                    title: "에러",
                    content: alertMessage,
                    primaryButtonTitle: "확인",
                    primaryAction: {
                        
                    }
                )
            )
//            .modifier(
//                SignCustomAlertModifier(
//                    isPresented: $showSignInAlert,
//                    title: "로그인 완료",
//                    content: alertMessage,
//                    primaryButtonTitle: "들어가기",
//                    primaryAction: {
//                        Task {
//                            let loginResult : (result : Bool, message: String) = try await AuthService.shared.login(withEmail:email, password:password)
//                            showAlert = loginResult.result
//                            alertMessage = loginResult.message
//                        }
//
//                    }
//                )
//            )
        }
        .toolbar {
            ToolbarItem {
            }
        }
        .background(Color.backgrounBlack)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInView()
        }
    }
}
