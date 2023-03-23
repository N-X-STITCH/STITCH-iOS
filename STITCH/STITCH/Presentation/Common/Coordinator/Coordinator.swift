//
//  Coordinator.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import UIKit

import RxSwift

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get }
    var disposeBag: DisposeBag { get set }
    
    func start()
    func finish()
    func popViewController()
    func popToRootViewController()
    func dismissViewController()
    func showAlert(message: String)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func popToRootViewController() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
        alertController.addAction(cancelAction)
        navigationController.present(alertController, animated: true)
    }
    
    func addPopEvent(_ coordinatorPublisher: Observable<CoordinatorEvent>) {
        coordinatorPublisher
            .asSignal(onErrorJustReturn: .pop)
            .emit()  { event in
                if .pop == event {
                    self.popViewController()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func addPopEvent(
        _ coordinatorPublisher: Observable<CoordinatorEvent>,
        _ navigationController: UINavigationController
    ) {
        coordinatorPublisher
            .asSignal(onErrorJustReturn: .pop)
            .emit()  { event in
                if .pop == event {
                    navigationController.popViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func addDismissEvent(_ coordinatorPublisher: Observable<CoordinatorEvent>) {
        coordinatorPublisher
            .asSignal(onErrorJustReturn: .pop)
            .emit() { event in
                if .dismiss == event {
                    self.dismissViewController()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func addEvent(
        _ coordinatorPublisher: Observable<CoordinatorEvent>,
        _ showViewController: @escaping () -> Void,
        _ coordinatorEvent: CoordinatorEvent
    ) {
        coordinatorPublisher
            .asSignal(onErrorJustReturn: .pop)
            .emit() { event in
                if coordinatorEvent == event {
                    showViewController()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func addEventWithNav(
        _ coordinatorPublisher: Observable<CoordinatorEvent>,
        _ showViewController: @escaping (UINavigationController) -> Void,
        _ navigationController: UINavigationController,
        _ coordinatorEvent: CoordinatorEvent
    ) {
        coordinatorPublisher
            .asSignal(onErrorJustReturn: .pop)
            .emit() { event in
                if coordinatorEvent == event {
                    showViewController(navigationController)
                }
            }
            .disposed(by: disposeBag)
    }
}
