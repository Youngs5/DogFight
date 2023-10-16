//
//  CustomContentTextField.swift
//  DogFight
//
//  Created by 오영석 on 2023/09/16.
//
import SwiftUI

struct CustomContentTextField: View {
    var maxLength: Int = 100
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 8)
                .stroke(isFocused ? Color.white : Color.clear, lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.fieldGrayColor))
            TextField(placeholder, text: $text, axis: .vertical)
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
                .multilineTextAlignment(.leading)
                .lineLimit(10, reservesSpace: true)

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
                    .padding([.top, .trailing], 20)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .frame(minHeight: 200, maxHeight: 500)
        .onChange(of: text, perform: { newValue in
            if newValue.count > maxLength {
                text = String(newValue.prefix(maxLength))
                isFocused = false
            }
        })
    }
}

struct CustomContentTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomContentTextField(placeholder: "ㅎㅎ", text: .constant(""))
    }
}
