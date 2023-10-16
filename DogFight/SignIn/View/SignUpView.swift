//
//  SignUpView.swift
//  DogFight
//
//  Created by 임대진 on 2023/09/17.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordCheck: String = ""
    @State private var nickname: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    @State private var showAlert = false
    @State private var showHelloAlert = false
    @State private var alertMessage = ""
    @Environment(\.dismiss) var dismiss
    private let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack{
            VStack {
                Text("회원가입")
                    .foregroundColor(.signInWhite)
                    .font(.system(size: 30))
                    .fontWeight(.semibold)
                    .padding(.bottom, 30)
                VStack(alignment: .leading) {
                    Group {
                        Group {
                            customSection("Email")
                            SignCustomTextField(placeholder: "EMAIL", text: $email)
                        }
                        Group {
                            customSection("Password")
                            SignCustomSecureField(placeholder: "PASSWORD", text: $password)
                        }
                        Group {
                            customSection("Password Check")
                            SignCustomSecureField(placeholder: "PASSWORD CHECK", text: $passwordCheck)
                        }
                        Group {
                            customSection("Name")
                            HStack {
                                SignCustomTextField(placeholder: "NAME", text: $lastName)
                                SignCustomTextField(placeholder: "SURNAME", text: $firstName)
                            }
                        }
                        Group {
                            customSection("Nickname")
                            SignCustomTextField(placeholder: "NICKNAME", text: $nickname)
                        }
                        Group {
                            customSection("Phone Number")
                            SignCustomTextField(placeholder: "PHONENUMBER",keyboardType: .numberPad, text: $phoneNumber)
                        }
                    }
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.none)
                    .padding(.horizontal, 30)
                    
                    
                }
                Button {
                    if !ValidationUtility.isValidEmail(email) {
                        showAlert = true
                        alertMessage = "이메일 형식이 올바르지 않습니다."
                    } else if password.count < 6 {
                        showAlert = true
                        alertMessage = "비밀번호는 6자리 이상이어야 합니다."
                    } else if passwordCheck != password {
                        showAlert = true
                        alertMessage = "비밀번호가 다릅니다."
                    } else if firstName.isEmpty {
                        showAlert = true
                        alertMessage = "이름을 입력해주세요."
                    }   else if lastName.isEmpty {
                        showAlert = true
                        alertMessage = "성을 입력해주세요."
                    } else if nickname.isEmpty {
                        showAlert = true
                        alertMessage = "닉네임을 입력해주세요."
                    } else if phoneNumber.isEmpty {
                        showAlert = true
                        alertMessage = "전화번호를 입력해주세요."
                    } else {
                        showHelloAlert = true
                    }
                } label: {
                    Text("SIGN UP")
                        .font(.custom("SigmarOne-Regular", size: 20))
                        .foregroundColor(.signInWhite)
                        .frame(width: screenWidth - 60, height: 55)
                        .background(.black)
                        .cornerRadius(8)
                        .padding(.top, 50)
                }
            }
//            .background(Color.blue)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgrounBlack)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "delete.backward")
                        .foregroundColor(.signInWhite)
                }

            }
        }
//        .alert(isPresented:$showAlert) {
//            Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("확인")))
//        }
        .modifier(
            SignCustomAlertModifier(
                isPresented: $showAlert,
                title: "에러",
                content: alertMessage,
                primaryButtonTitle: "확인",
                primaryAction: {
                    Task{
                        try await AuthService.shared.createUser(withEmail: email, password: password, nickname: nickname, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
                        }
                    
                }
            )
        )
//        .alert("회원가입", isPresented: $showAlert) {
//            Button("완료", role: .cancel) {
//                Task{
//                    try await AuthService.shared.createUser(withEmail: email, password: password, nickname: nickname, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
//                }
//            }
//        } message: {
//            Text("\(lastName + firstName)님 반갑습니다.")
//        }
        .modifier(
            SignCustomAlertModifier(
                isPresented: $showHelloAlert,
                title: "회원가입 완료",
                content: "\(lastName + firstName)님 반갑습니다.",
                primaryButtonTitle: "들어가기",
                primaryAction: {
                    Task{
                        try await AuthService.shared.createUser(withEmail: email, password: password, nickname: nickname, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
                        }
                    
                }
            )
        )
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpView()
        }
    }
}
