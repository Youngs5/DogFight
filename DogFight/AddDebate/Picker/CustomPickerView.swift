//
//  CustomPickerView.swift
//  DogFight
//
//  Created by 오영석 on 2023/09/15.
//
import SwiftUI

struct CustomPickerView: View {
    @State private var isPresented: Bool = false
    @Binding var selectedData: Category?
    @Binding var isPickerSelected: Bool
    
    let placeholder: String

    var body: some View {
        Button {
            isPresented.toggle()
            isPickerSelected.toggle()
        } label: {
            HStack {
                Spacer()
                Text(selectedData != nil ? selectedData?.title ?? "" : placeholder)
                    .foregroundColor(selectedData != nil ? .white: .gray)
                    .font(.custom("SigmarOne-Regular", size: UIScreen.main.bounds.width * 0.04))
                    .padding(15)
                Spacer()
                Image(systemName: "chevron.down")
                    .rotationEffect(Angle(degrees: isPresented ? 180 : 0))
                    .foregroundColor(.white)
            }
            .font(.headline)
            .padding(.horizontal)
            .frame(width: UIScreen.main.bounds.width * 0.6)
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.backgrounBlack, lineWidth: 2)
                .frame(width: UIScreen.main.bounds.width * 0.6)
                .background(Color.fieldGrayColor)
                .cornerRadius(10)
        }
        .overlay(alignment: .top) {
            VStack {
                if isPresented {
                    Spacer(minLength: 60)
                    PickerMenuList { menu in
                        isPresented = false
                        selectedData = menu
                        isPickerSelected.toggle()
                    }
                }
            }
        }

    }
}

struct CustomPickerView_Previews: PreviewProvider {
    @State static var selectedData: Category? = nil
    @State static var isPickerSelected: Bool = false
    
    static var previews: some View {
        CustomPickerView(selectedData: $selectedData, isPickerSelected: $isPickerSelected, placeholder: "Category")
    }
}
