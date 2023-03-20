//
//  MyPageEditViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import Foundation

import RxSwift

final class MyPageEditViewModel: ViewModel {
    
    var user: User!
    
    struct Input {
        let matchImage: Observable<Data>
        let viewWillAppear: Observable<Bool>
        let sportSelected: Observable<IndexPath>
        let sportDeselected: Observable<IndexPath>
        let completeButtonTap: Observable<Void>
    }
    
    struct Output {
        let userObservable: Observable<User>
        let completeUpdateUser: Observable<User>
        let imageURLDisposable: Disposable
        let selectDisposable: Disposable
        let deselectDisposable: Disposable
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
        
        let imageURLDisposable = input.matchImage
            .flatMap { [weak self] data -> Observable<String> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.myPageUseCase.uploadImage(data: data, path: self.user.id)
            }
            .withUnretained(self)
            .subscribe { owner, imageURL in
                owner.user.profileImageURL = imageURL
            }
        
        let selectDisposable = input.sportSelected
            .withUnretained(self)
            .subscribe { owner, indexPath in
                let sport = Sport.allCases[indexPath.row + 1]
                if !owner.user.interestedSports.contains(sport) {
                    owner.user.interestedSports.append(sport)
                }
            }
        
        let deselectDisposable = input.sportDeselected
            .withUnretained(self)
            .subscribe { owner, indexPath in
                let sport = Sport.allCases[indexPath.row + 1]
                if owner.user.interestedSports.contains(sport) {
                    owner.user.interestedSports.removeAll { $0 == sport }
                }
            }
        
        let userObservable = input.viewWillAppear
            .flatMap { [weak self] _ -> Observable<User> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.userUseCase.fetchLocalUser()
            }
            .map { user -> User in
                self.user = user
                return user
            }
            .share()
        
        let completeUpdateUser = input.completeButtonTap
            .flatMap { [weak self] _ -> Observable<User> in
                guard let self else { return .error(NetworkError.unknownError) }
                return self.myPageUseCase.update(user: self.user)
            }
        
        return Output(
            userObservable: userObservable,
            completeUpdateUser: completeUpdateUser,
            imageURLDisposable: imageURLDisposable,
            selectDisposable: selectDisposable,
            deselectDisposable: deselectDisposable
        )
    }
}
