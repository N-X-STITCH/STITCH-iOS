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
    func dismissViewController()
    func showAlert()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
    
    func showAlert() {
        
    }
    
    func addPopEvent(_ viewController: BaseViewController) {
        viewController.coordinatorPublisher
            .subscribe { event in
                if .pop == event {
                    self.popViewController()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func addDismissEvent(_ viewController: BaseViewController) {
        viewController.coordinatorPublisher
            .subscribe { event in
                if .dismiss == event {
                    self.dismissViewController()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func addNextEvent(
        _ viewController: BaseViewController,
        _ showViewController: @escaping () -> Void,
        _ coordinatorEvent: CoordinatorEvent = .next
    ) {
        viewController.coordinatorPublisher
            .subscribe { event in
                if coordinatorEvent == event {
                    showViewController()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func addNextEventWithNav(
        _ viewController: BaseViewController,
        _ showViewController: @escaping (UINavigationController) -> Void,
        _ navigationController: UINavigationController,
        _ coordinatorEvent: CoordinatorEvent = .next
    ) {
        viewController.coordinatorPublisher
            .subscribe { event in
                if coordinatorEvent == event {
                    showViewController(navigationController)
                }
            }
            .disposed(by: disposeBag)
    }
}
