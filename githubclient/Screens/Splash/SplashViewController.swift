//
//  SplashViewController.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 31/5/23.
//

import UIKit

import RxSwift

class SplashViewController: UIViewController, ISplashScreen {

    let disposeBag = DisposeBag()

    var viewModel: ISplashViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel
            .transform(viewDidAppear: self.rx.methodInvoked(#selector(viewDidAppear))
                .map { _ in }
                .asSignal { _ in .never() })
            .subscribe()
            .disposed(by: self.disposeBag)
    }
}
