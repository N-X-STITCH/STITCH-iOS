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
        let tableViewSelect: Observable<IndexPath>
    }
    
    struct Output {
        let logoutResult: Observable<Void>
        let signoutResult: Observable<Void>
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
    
    func transform(input: Input) -> Output {
        
        let tableViewSelect = input.tableViewSelect
        
        let logoutResult = tableViewSelect
            .flatMap { indexPath -> Observable<Void> in
                if indexPath == IndexPath(row: AccountSection.logout.row, section: SettingSection.account.section) {
                    return self.userUseCase.logout()
                } else {
                    return Observable.error(SocialLoginError.logout)
                }
            }
        
        let signoutResult = tableViewSelect
            .flatMap { indexPath -> Observable<Void> in
                if indexPath == IndexPath(row: AccountSection.secession.row, section: SettingSection.account.section) {
                    return self.myPageUseCase.deleteUser()
                        .withLatestFrom(self.userUseCase.logout())
                } else {
                    return Observable.error(SocialLoginError.logout)
                }
            }
        
        return Output(logoutResult: logoutResult, signoutResult: signoutResult)
    }
}
