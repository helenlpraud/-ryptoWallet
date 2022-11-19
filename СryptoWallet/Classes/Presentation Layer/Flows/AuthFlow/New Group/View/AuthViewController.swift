//
//  AuthViewController.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 02.11.2022.
//

import UIKit

protocol AuthModule: Presentable {

    var onFinish: (() -> Void)? { get set }
}

final class AuthViewController: UIViewController, AuthModule {
    
    var onFinish: (() -> Void)?
    
    // MARK: ViewModel
    
    var viewModel: AuthViewModelProtocol?
    
    // MARK: Subviews
    
    private let authView = AuthView()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.backgroundAuth
        view.addSubview(authView)
        authView.frame = view.frame
        guard let viewModel = viewModel as? AuthViewModel else { return }
        authView.configure(with: viewModel)
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel?.onFinish =  { [weak self] in
            self?.onFinish?()
        }
    }
}
