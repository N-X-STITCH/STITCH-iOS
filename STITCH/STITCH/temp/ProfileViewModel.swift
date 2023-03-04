//
//  ProfileViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/02/23.
//

import Foundation

import RxCocoa
import RxSwift

final class ProfileViewModel: ViewModel {
    
    struct Input {
        let configureCollectionView: Observable<Void>
        let profileImage: Observable<Data?>
    }
    
    struct Output {
        let configureCollectionViewData: Observable<[ProfileText]>
    }
    
    // MARK: - Properties
    
//    private let profileUseCase: ProfileUseCase
    
    private var selectedIndexPath: IndexPath?
    
    // MARK: - Initializer
    
//    init(profileUseCase: ProfileUseCase) {
//        self.profileUseCase = profileUseCase
//    }
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        
        let configureCollectionViewData = input.configureCollectionView
            .flatMap { _ in
                return Observable.just(ProfileText.allCases)
            }
            .asObservable()
            
        
        return Output(configureCollectionViewData: configureCollectionViewData)
    }
}
