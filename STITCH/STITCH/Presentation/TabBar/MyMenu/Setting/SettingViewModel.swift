//
//  SettingViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import Foundation

import RxSwift

final class SettingViewModel: ViewModel {
    
    struct Input {
    }
    
    struct Output {
    }
    
    // MARK: - Properties
    
    private let userUseCase: UserUseCase
    private let myPageUseCase: MyPageUseCase
    
    // MARK: - Initializer
    
    init(
        userUseCase: UserUseCase,
        myPageUseCase: MyPageUseCase
    ) {
        self.userUseCase = userUseCase
        self.myPageUseCase = myPageUseCase
    }
    
    // MARK: - Methods
    
    func logoutResult() -> Observable<Void> {
        return self.userUseCase.logout()
    }
    
    func signOutResult() -> Observable<Void> {
        return self.myPageUseCase.deleteUser()
            .withLatestFrom(self.userUseCase.logout())
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
