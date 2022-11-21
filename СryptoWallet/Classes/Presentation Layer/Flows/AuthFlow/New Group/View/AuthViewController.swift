//
//  AuthViewController.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 02.11.2022.
//

import UIKit

protocol AuthModule: Presentable {
    
    // MARK: Public Properties

    var onFinish: (() -> Void)? { get set }
}

final class AuthViewController: UIViewController, AuthModule {
    
    // MARK: Public Properties
    
    var onFinish: (() -> Void)?
    
    // MARK: ViewModel
    
    var viewModel: AuthViewModelProtocol?
    
    // MARK: Subviews
    
    private let authView = AuthView()
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        addObservers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.backgroundAuth
        view.addSubview(authView)
        authView.frame = super.view.frame
        guard let viewModel = viewModel as? AuthViewModel else { return }
        authView.configure(with: viewModel)
        bindViewModel()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        viewModel?.keyboardWillShow(notification: notification)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        viewModel?.keyboardWillHide(notification: notification)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Binding Model
    
    private func bindViewModel() {
        viewModel?.onFinish = { [weak self] in
            self?.onFinish?()
        }
        
        viewModel?.onShowAlertShowed = { [weak self] alert in
            let alertError = UIAlertController(title: alert.title, message: alert.message, preferredStyle: UIAlertController.Style.alert)
            alertError.addAction(UIAlertAction(title: alert.actions[0].title, style: UIAlertAction.Style.default, handler: nil))
            self?.present(alertError, animated: true, completion: nil)
        }
        
        viewModel?.onKeyboardWillShow = { [weak self] height in
            self?.authView.updateForKeyboardWillShowState(height: height)
        }
        
        viewModel?.onKeyboardWillHide = { [weak self] in
            self?.authView.updateForKeyboardWillHideState()
        }
    }
}
