//
//  DefaultFireStorageRepository.swift
//  STITCH
//
//  Created by neuli on 2023/03/16.
//

import Foundation

import FirebaseStorage
import RxSwift

final class DefaultFireStorageRepository: FireStorageRepository {
    
    func uploadImage(data: Data, path: String) -> Observable<String> {
        return Single.create { single in
            let ref = Storage.storage().reference().child(path)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let uploadTask = ref.putData(data, metadata: metadata) { metadata, error in
                if let error {
                    single(.failure(error))
                }
                
                ref.downloadURL { url, _ in
                    guard let url = url else {
                        single(.failure(NetworkError.invalidURLError))
                        return
                    }
                    single(.success(url.absoluteString))
                }
            }
            return Disposables.create {
                uploadTask.cancel()
            }
        }
        .asObservable()
    }
}
