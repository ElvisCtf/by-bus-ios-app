//
//  SplashScreen.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/3/2025.
//

import UIKit
import RxSwift
import RxCocoa

final class SplashScreen: UIViewController {
    private lazy var splashScreenView = SplashScreenView()
    private let viewModel = SplashScreenViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setBinding()
        
        Task {
            await viewModel.getRoutes()
        }
    }
    
    private func setUI() {
        view = splashScreenView
    }
    
    private func setBinding() {
        viewModel.routesRelay.asSignal()
            .emit(onNext: { [weak self] routes in
                guard let self else { return }
                self.splashScreenView.stopSpinner()
                let mainController = TabBarController(routes: routes)
                mainController.modalTransitionStyle = .crossDissolve
                mainController.modalPresentationStyle = .fullScreen
                self.present(mainController, animated: true)
            }).disposed(by: disposeBag)
    }
}
