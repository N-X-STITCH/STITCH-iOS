//
//  InterestedSportsViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/02/24.
//

import Foundation

import RxCocoa
import RxSwift

final class InterestedSportsViewModel: ViewModel {
    
    struct Input {
        let configureCollectionView: Observable<Void>
        let sportSelected: Observable<IndexPath>
        let sportDeselected: Observable<IndexPath>
    }
    
    struct Output {
        let configureCollectionViewData: Observable<[Sport]>
        let selectedIndexPath: BehaviorRelay<[IndexPath]>
        let selectDisposable: Disposable
        let deselectDisposable: Disposable
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    func transform(input: Input) -> Output {
        
        let configureCollectionViewData = input.configureCollectionView
            .flatMap { return Observable.just(Sport.allCases).asObservable() }
            .asObservable()
        
        let selectedIndexPath = BehaviorRelay<[IndexPath]>(value: [])
        
        let selectDisposable = input.sportSelected
            .subscribe { indexPath in
                var selected = selectedIndexPath.value
                selected.append(indexPath)
                selectedIndexPath.accept(selected)
            }
        
        let deselectDisposable = input.sportDeselected
            .subscribe { indexPath in
                var selected = selectedIndexPath.value
                selected.removeAll { $0 == indexPath }
                selectedIndexPath.accept(selected)
            }
        
        return Output(
            configureCollectionViewData: configureCollectionViewData,
            selectedIndexPath: selectedIndexPath,
            selectDisposable: selectDisposable,
            deselectDisposable: deselectDisposable
        )
    }
}

