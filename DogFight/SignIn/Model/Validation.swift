//
//  SignUpView.swift
//  DogFight
//
//  Created by 임대진 on 2023/09/17.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

public enum InputError: String {
    case loggedOut
    case necessaryFieldMissing
    case invalidEmail
    case invalidUserNumber
    case invalidUrl
    case failedToSave
    
    var description: String {
        switch self {
        case .loggedOut:
            return "현재 로그아웃 상태입니다. 로그인 해주세요."
        case .necessaryFieldMissing:
            return "필수 정보를 입력해 주세요."
        case .invalidEmail:
            return "이메일의 형식이 올바르지 않습니다."
        case .invalidUserNumber:
            return "전화번호의 형식이 올바르지 않습니다."
        case .invalidUrl:
            return "URL의 형식이 올바르지 않습니다."
        case .failedToSave:
            return "프로필 수정 사항을 저장하는 데 오류가 발생했습니다. 입력 항목을 확인해 주세요."
        }
    }
}

public struct ValidationUtility {
    public static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    public static func isValidNumber(_ number: String) -> InputError? {
        let numberPlaces = 3 // 전화번호 자릿수
        let firstSegmentLengths = [3] // 전화번호 첫째 자릿수
        let secondSegmentLengths: [Int] = [3, 4] // 전화번호 둘째 자릿수
        let thirdSegmentLengths = [3] // 전화번호 셋째 자릿수
        
        if !number.contains("-") {
            return .invalidUserNumber
        }
        
        let segments: [String] = number.components(separatedBy: "-")
        
        if segments.count != numberPlaces {
            return .invalidUserNumber
        }
        
        for index in 0 ..< segments.count {
            switch index {
            case 0:
                if !firstSegmentLengths.contains(segments[index].count) {
                    return .invalidUserNumber
                }
            case 1:
                if !secondSegmentLengths.contains(segments[index].count) {
                    return .invalidUserNumber
                }
            case 2:
                if !thirdSegmentLengths.contains(segments[index].count) {
                    return .invalidUserNumber
                }
            default:
                return .invalidUserNumber
            }
        }
        
        return nil
    }
    
}
