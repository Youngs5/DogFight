//
//  View+Extension.swift
//  DogFight
//
//  Created by 방유빈 on 2023/09/15.
//

import Foundation
import SwiftUI

/// 서치바 플레이스 홀더 색깔 주기
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func customSection(_ text: String) -> some View {
        Text(text)
            .foregroundColor(.signInWhite)
            .font(.custom("SigmarOne-Regular", size: 20))
            .frame(height: 20)
    }
    
    func customToolbar() -> some View {
        modifier(CustomToolbar())
    }
}
