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

final class AuthViewController: UIViewController,
                                AuthModule {
    
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
        view.backgroundColor = Colors.backgroundAuth
        addUITapGestureRecognizers()
        setSubview()
        bindViewModel()
    }
    
    func setSubview() {
        view.addSubview(authView)
        authView.frame = view.frame
        guard let viewModel = viewModel as? AuthViewModel else { return }
        authView.configure(with: viewModel)
    }
    
    func addUITapGestureRecognizers() {
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: Actions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let height = keyboardSize.height
            authView.updateForKeyboardWillShowState(height: height)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        authView.updateForKeyboardWillHideState()
    }
    
    // MARK: Private Functions
    
    private func addObservers() {
        // #error почему не отписалась?
        // да и вообще оно надо в твоем случае. Я не проверял, но для айфона 5
        // по моему все влезет

        // по хорошему добавь логику нажатия на клавишу некст
        // что бы курсор или переходил на ввод пароля,
//        или убирал клавиатуру и делал запрос на бэк
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
        
        viewModel?.onFieldsAreFilled = { [weak self] in
            self?.dismissKeyboard()
        }
        
        viewModel?.onFieldIsEmpty = { [weak self] state in
            self?.authView.updateRecognizer(with: state)
        }
    }
    
    deinit {
         NotificationCenter.default.removeObserver(self)
    }
}
