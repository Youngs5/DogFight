//
//  Text+Extension.swift
//  DogFight
//
//  Created by 방유빈 on 2023/09/15.
//

import Foundation
import SwiftUI

//Category 버튼 디자인
extension Text {
    func categoryStyle(background: Color, foreground: Color) -> some View {
        self
            .font(.caption)
            .bold()
            .foregroundColor(foreground)
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
            .background(background)
            .cornerRadius(15)
    }
}
