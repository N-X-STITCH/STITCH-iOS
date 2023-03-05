//
//  UserDefaultsService.swift
//  STITCH
//
//  Created by neuli on 2023/03/04.
//

import Foundation

import RxSwift

protocol UserDefaultsService {
    func save<T>(value: T, forKey key: String)
    func value<T>(valueType: T.Type, forKey key: String) -> Observable<T?>
    func stringValue(forKey key: String) -> Observable<String?>
    func delete(forKey key: String)
}

final class DefaultUserDefaultsService: UserDefaultsService {

    // MARK: - Properties

    private let standard = UserDefaults.standard

    // MARK: - Methods

    func save<T>(value: T, forKey key: String) {
        standard.set(value, forKey: key)
    }

    func value<T>(valueType: T.Type, forKey key: String) -> Observable<T?> {
        guard let value = standard.object(forKey: key) as? T else {
            return Single<T?>.just(nil).asObservable()
        }
        return Single<T?>.just(value).asObservable()
    }

    func stringValue(forKey key: String) -> Observable<String?> {
        let value = standard.string(forKey: key)
        return Single<String?>.just(value).asObservable()
    }

    func delete(forKey key: String) {
        standard.removeObject(forKey: key)
    }
}
