//
//  CLLocationDelegateProxy.swift
//  STITCH
//
//  Created by neuli on 2023/03/13.
//

import CoreLocation
import Foundation

import RxCocoa
import RxSwift

enum CLLocationFail: Error {
    case fail
}

final class CLLocationDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {
    
    static func registerKnownImplementations() {
        register { locationManager -> CLLocationDelegateProxy in
            return CLLocationDelegateProxy(parentObject: locationManager, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: CLLocationManager) -> CLLocationManagerDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: CLLocationManagerDelegate?, to object: CLLocationManager) {
        object.delegate = delegate
    }
}

extension Reactive where Base: CLLocationManager {
    var delegate: CLLocationDelegateProxy {
        return CLLocationDelegateProxy.proxy(for: base)
    }
    
    var didChangeAuthorization: ControlEvent<CLAuthorizationStatus> {
        let source: Observable<CLAuthorizationStatus> = delegate
            .methodInvoked(.didChangeAuthorization)
            .map { manager in
                guard let manager = manager.last as? CLLocationManager else { return .denied }
                return manager.authorizationStatus
            }
        return ControlEvent(events: source)
    }
    
    var didChangeLocation: ControlEvent<CLLocation> {
        let source: Observable<CLLocation> = delegate
            .methodInvoked(.didChangeLocation)
            .map { result in
                guard let result = result.last as? [CLLocation] else { return CLLocation() }
                guard let location = result.last else { return CLLocation() }
                return location
            }
        return ControlEvent(events: source)
    }
    
    var didFailWithError: ControlEvent<Error> {
        let source: Observable<Error> = delegate
            .methodInvoked(.didFailWithError)
            .map { result in
                guard let error = result.last as? Error else { return CLLocationFail.fail }
                return error
            }
        return ControlEvent(events: source)
    }
}

extension Selector {
    static let didChangeAuthorization = #selector(CLLocationManagerDelegate.locationManagerDidChangeAuthorization(_:))
    static let didChangeLocation = #selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:))
    static let didFailWithError = #selector(CLLocationManagerDelegate.locationManager(_:didFailWithError:))
}
