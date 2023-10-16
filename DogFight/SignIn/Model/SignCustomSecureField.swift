//
//  CustomSecureField.swift
//  DogFight
//
//  Created by 임대진 on 2023/09/15.
//

import SwiftUI

@available(iOS 15.0, *)
public struct SignCustomSecureField: View {
    var maxLength: Int = 100
    var backgroundColor: Color = .white
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    public init(maxLength: Int = 100, backgroundColor: Color = .signInWhite, placeholder: String, keyboardType: UIKeyboardType = .default, text: Binding<String>, isFocused: Bool = false) {
        self.maxLength = maxLength
        self.backgroundColor = backgroundColor
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self._text = text
        self.isFocused = isFocused
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(isFocused ? Color.black : Color.clear, lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(backgroundColor))
            SecureField(placeholder, text: $text)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .font(.custom("SigmarOne-Regular", size: 20))
//                .font(.system(size: 20))
                .foregroundColor(.black)
                .focused($isFocused)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            if isFocused {
                HStack {
                    Spacer()
                    Button(action: {
                        text = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.black)
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
@available(iOS 15.0, *)
struct SignCustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.backgrounBlack.edgesIgnoringSafeArea(.all)
            SignCustomSecureField(placeholder: "1", text: .constant("1222"))
        }
    }
}
