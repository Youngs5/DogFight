//
//  SignUpView.swift
//  DogFight
//
//  Created by 임대진 on 2023/09/17.
//

import Foundation
import SwiftUI
import Combine
import Firebase


class InitialViewStore: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscriber()
    }
    
    private func setupSubscriber() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
    }
}
