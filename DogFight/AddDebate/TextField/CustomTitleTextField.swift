//
//  CustomTextField.swift
//  DogFight
//
//  Created by 오영석 on 2023/09/15.
//
import SwiftUI

struct CustomTitleTextField: View {
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
            TextField(placeholder, text: $text, prompt: Text("Insert Title").foregroundColor(.gray)
            )
                .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 40))
                .font(.custom("SigmarOne-Regular", size: UIScreen.main.bounds.width * 0.04))
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
        .frame(width: UIScreen.main.bounds.width * 0.6)
        .frame(minHeight: 42, maxHeight: 52)
        .onChange(of: text, perform: { newValue in
            if newValue.count > maxLength {
                text = String(newValue.prefix(maxLength))
                isFocused = false
            }
        })
    }
}

struct CustomTitleTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTitleTextField(placeholder: "ㅎㅎ", text: .constant(""))
    }
}
