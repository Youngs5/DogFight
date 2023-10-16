//
//  PickerMenuList.swift
//  DogFight
//
//  Created by 오영석 on 2023/09/15.
//
import SwiftUI

struct PickerMenuList: View {
    let list = Category.list
    let sendAction: (_ data: Category) -> Void

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(list) { data in
                    Button {
                        sendAction(data)
                    } label: {
                        Text(data.title)
                            .font(.custom("SigmarOne-Regular", size: UIScreen.main.bounds.width * 0.04))
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.vertical)
        }
        .frame(height: UIScreen.main.bounds.height * 0.37)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.backgrounBlack, lineWidth: 2)
                .frame(width: UIScreen.main.bounds.width * 0.6)
                .background(Color.fieldGrayColor)
                .cornerRadius(10)
        }
    }
}

struct PickerMenuList_Previews: PreviewProvider {
    static var previews: some View {
        PickerMenuList(sendAction: { _ in })
    }
}
