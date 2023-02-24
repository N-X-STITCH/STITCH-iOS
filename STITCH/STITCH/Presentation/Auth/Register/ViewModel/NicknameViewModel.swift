//
//  NicknameViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/02/22.
//

import Foundation

import RxCocoa
import RxSwift

final class NicknameViewModel: ViewModel {
    
    struct Input {
        let nicknameTextFieldChanged: Observable<String>
    }
    
    struct Output {
        let nicknameValidation: Driver<NicknameValidation>
    }
    
    // MARK: - Properties
    
    private let nicknameUseCase: NicknameUseCase
    
    // MARK: - Initializer
    
    init(nicknameUseCase: NicknameUseCase) {
        self.nicknameUseCase = nicknameUseCase
    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        let nicknameValidation = input.nicknameTextFieldChanged
            .distinctUntilChanged()
            .withUnretained(self)
            .flatMap { owner, nickname in
                return owner.nicknameUseCase.validate(nickname: nickname)
            }
            .asDriver(onErrorJustReturn: .ok)
        
        return Output(nicknameValidation: nicknameValidation)
    }
}
