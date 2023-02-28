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
    
    var loginInfo: LoginInfo? = nil
    var sports: [Sport] = []
    var location: String? = nil
    
    struct Input {
        let signupButtonTap: Observable<Void>
    }
    
    struct Output {
        
    }
    
    // MARK: - Initializer
    
    init() { }
    
    // MARK: - Methods
    
//    func transform(_ input: Input) -> Output {
//        input.signupButtonTap
//    }
}
