//
//  SignupViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/02/24.
//

import Foundation

import RxCocoa
import RxSwift

final class SignupViewModel {
    
    // MARK: - Properties
    
    let nickname: Observable<String>? = nil
    let profileImage: Observable<Data?>? = nil
    let profileText: Observable<ProfileText>? = nil
    let location: Observable<String>? = nil
    let sports: Observable<[Sport]>? = nil
    
    struct Input {
        let signupButtonTap: Observable<Void>
    }
    
    struct Output {
        
    }
    
    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Methods
}
