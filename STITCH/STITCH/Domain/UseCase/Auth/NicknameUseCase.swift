//
//  NicknameUseCase.swift
//  STITCH
//
//  Created by neuli on 2023/02/22.
//

import Foundation

import RxSwift

protocol NicknameUseCase {
    func validate(nickname: String) -> Observable<NicknameValidation>
}

final class DefaultNicknameUseCase: NicknameUseCase {
    
    func validate(nickname: String) -> Observable<NicknameValidation> {
        let count = nickname.count
        if !checkMinLength(count) {
            return validationObservable(.minLength)
        } else if !checkMaxLength(count) {
            return validationObservable(.maxLength)
        } else if !checkInvalidWord(nickname) {
            return validationObservable(.invalidWord)
        } else {
            return validationObservable(.ok)
        }
    }
    
    private func checkMinLength(_ count: Int) -> Bool {
        return 2 <= count
    }
    
    private func checkMaxLength(_ count: Int) -> Bool {
        return count <= 10
    }
    
    private func checkInvalidWord(_ nickname: String) -> Bool {
        if let _ = nickname.range(of: NicknameValidation.regexp, options: .regularExpression) {
            return true
        } else {
            return false
        }
    }
    
    private func checkDuplication(_ nickname: String) -> Bool {
        // TODO: 중복확인
        return true
    }
    
    private func validationObservable(_ validation: NicknameValidation) -> Observable<NicknameValidation> {
        return Single<NicknameValidation>.create { single in
            single(.success(validation))
            return Disposables.create()
        }
        .asObservable()
    }
}
