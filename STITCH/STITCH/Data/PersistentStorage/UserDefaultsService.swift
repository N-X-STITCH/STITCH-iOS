//
//  UserDefaultsService.swift
//  STITCH
//
//  Created by neuli on 2023/03/04.
//

import Foundation

import RxSwift

protocol UserDefaultsService {
    func save<T: Codable>(value: T, forKey key: String)
    func value<T: Codable>(valueType: T.Type, forKey key: String) -> Observable<T?>
    func stringValue(forKey key: String) -> Observable<String?>
    func delete(forKey key: String)
}

final class DefaultUserDefaultsService: UserDefaultsService {

    // MARK: - Properties

    private let standard = UserDefaults.standard

    // MARK: - Methods

    func save<T: Codable>(value: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(value) {
            standard.set(data, forKey: key)
        }
    }

    func value<T: Codable>(valueType: T.Type, forKey key: String) -> Observable<T?> {
        let decoder = JSONDecoder()
        guard let data = standard.object(forKey: key) as? Data,
              let value = try? decoder.decode(T.self, from: data) else {
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
