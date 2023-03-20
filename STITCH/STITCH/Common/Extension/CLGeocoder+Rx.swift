//
//  CLGeocoder+Rx.swift
//  STITCH
//
//  Created by neuli on 2023/03/17.
//
//  https://gist.github.com/danielt1263/64bda2a32c18b8c28e1e22085a05df5a
//  comment:
//  The documentation for CLGeocoder says that you can't execute a geocode request while one is outstanding. So I have implemented a semaphore to ensure that calls happen sequentially.

import CoreLocation
import Foundation

import RxSwift

private let semaphore = DispatchSemaphore(value: 1)
private let scheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "CLGeocoderRx")

private func curry2<A, B, C>(_ f: @escaping (A, B) -> C, _ a: A) -> (B) -> C {
    return { b in f(a, b) }
}

extension Reactive where Base: CLGeocoder {
    func reverseGeocodeLocation(_ location: CLLocation) -> Observable<[CLPlacemark]> {
        return Observable<[CLPlacemark]>.create { observer in
            semaphore.wait()
            geocodeHandler(observer: observer, geocode: curry2(base.reverseGeocodeLocation(_:completionHandler:), location))
            return Disposables.create(with: cancel(base))
        }
        .subscribe(on: scheduler)
    }
    
    private func geocodeHandler(observer: AnyObserver<[CLPlacemark]>, geocode: @escaping (@escaping CLGeocodeCompletionHandler) -> Void) {
        geocode { placemarks, error in
            if let placemarks {
                observer.onNext(placemarks)
                observer.onCompleted()
            } else if let error {
                observer.onError(error)
            } else {
                observer.onError(NetworkError.unknownError)
            }
        }
    }

    private func cancel(_ geocoder: CLGeocoder) -> () -> Void {
        return {
            geocoder.cancelGeocode()
            semaphore.signal()
        }
    }
}
