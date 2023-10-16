//
//  MyProfileChangeView.swift
//  DogFight
//
//  Created by 윤경환 on 2023/09/15.
//

import SwiftUI

struct MyProfileChangeView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var myInfoStore: MyProfileStore
    @EnvironmentObject private var tabStore: TabStore
    var editType: EditType
    
    var body: some View {
        VStack {
            Text("\(myInfoStore.editType.name)수정")
                .font(.title3)
                .foregroundColor(.white)
                .fontWeight(.bold)
            HStack {
                Text("\(myInfoStore.editType.name)정보는 다른 유저에게 보여집니다.")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.top, 10)
            
            switch myInfoStore.editType {
            case .name:
                HStack {
                    CustomMyPageTitleTextField(placeholder: "First Name", text: $myInfoStore.myupdateProfile.firstName)
                    CustomMyPageTitleTextField(placeholder: "last Name", text: $myInfoStore.myupdateProfile.lastName)
                }
                .padding(.horizontal)
                
            case .phoneNumber:
                CustomMyPageTitleTextField(maxLength: 100, placeholder: "Phone Number", keyboardType: .numberPad, text: $myInfoStore.myupdateProfile.phoneNumber)
                    .padding(.horizontal)
            case .email:
                CustomMyPageTitleTextField(placeholder: "Email", text: $myInfoStore.myupdateProfile.email)
                    .padding(.horizontal)
                
            case .nickname:
                CustomMyPageTitleTextField(placeholder: "Nickname", text: $myInfoStore.myupdateProfile.nickname)
                    .padding(.horizontal)
            }
            Button {
                Task {
                    do{
                        try await myInfoStore.updateUserData()
                    } catch {
                        debugPrint("UpdateError")
                    }
                }
                dismiss()
            } label: {
                Text("완료")
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .background(Color.listGrayColor)
                    .cornerRadius(15)
                    .padding(20)
                    .foregroundColor(.white)
            }
            .buttonStyle(.automatic)
            .disabled(myInfoStore.isButtonDisabled)
            Spacer()
        }
        .background(Color.backgrounBlack, ignoresSafeAreaEdges: .all)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "delete.backward")
                        .foregroundColor(.white)
                }
            }
        }
        .toolbar(.hidden, for:.tabBar)
        .onAppear {
            tabStore.isShowingTab = false
            myInfoStore.editType = editType
        }
        .onDisappear{
            tabStore.isShowingTab = true
        }
    }
}

struct MyProfileChangeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyProfileChangeView(editType: .name)
                .environmentObject(MyProfileStore())
                .environmentObject(TabStore())
        }
    }
}

struct CustomMyPageTitleTextField: View {
    var maxLength: Int = 100
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(isFocused ? Color.white : Color.clear, lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.fieldGrayColor))
            TextField("", text: $text)
                .autocapitalization(.none)
                .placeholder(when: text.isEmpty, placeholder: {
                    Text(placeholder)
                        .foregroundColor(Color(hex: "#94949A"))
                })
                .foregroundColor(.white)
            
                .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 40))
                .foregroundColor(.white)
                .focused($isFocused)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .background(Color.fieldGrayColor)
                .padding(.vertical, 12)
                .padding(.horizontal, 8)

            if isFocused {
                HStack {
                    Spacer()
                    Button(action: {
                        text = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                    })
                    .padding(.trailing, 20)
                }
            }
        }
        .frame(minHeight: 42, maxHeight: 52)
        .onChange(of: text, perform: { newValue in
            if newValue.count > maxLength {
                text = String(newValue.prefix(maxLength))
                isFocused = false
            }
        })
    }
}
