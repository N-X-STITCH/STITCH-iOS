//
//  ViewModel.swift
//  STITCH
//
//  Created by neuli on 2023/02/22.
//

import Foundation

import RxSwift

protocol ViewModel: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
