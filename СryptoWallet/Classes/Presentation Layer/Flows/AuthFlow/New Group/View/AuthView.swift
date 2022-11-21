//
//  AuthView.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 18.11.2022.
//

import UIKit

final class AuthView: UIScrollView {
    
    // MARK: Constants
    
    enum Constants {
        
        static var height: Double {
            return 55.0
        }
        
        static var width: Double {
            return 300.0
        }
        
        static var offsetBottom: Double {
            return 20.0
        }
        
        static var offsetTop: Double {
            return 250.0
        }
        
        static var insetLeading: Double {
            return 16.0
        }
        
        static var cornerRadius: Double {
            return 5.0
        }
        
        static var borderWidth: Double {
            return 2.0
        }
    }
    
    // MARK: ViewModel
    
    var viewModel: AuthViewModelProtocol?
    
    // MARK: Subviews
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loginUIView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.borderColor = Colors.borderAuth
        view.layer.borderWidth = Constants.borderWidth
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let passwordUIView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.borderColor = Colors.borderAuth
        view.layer.borderWidth = Constants.borderWidth
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: StringsAuth.loginPlaceholderAuth,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.placeholderAuth]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(
            string: StringsAuth.passwordPlaceholderAuth,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.placeholderAuth]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let entryButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringsAuth.buttonTitleAuth, for: .normal)
        button.setTitleColor(Colors.buttonTitleAuth, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.borderColor = Colors.buttonBorderColorAuth
        button.layer.borderWidth = Constants.borderWidth
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        self.backgroundColor = Colors.backgroundAuth
        
        addContainerView()
        addLoginUIView()
        addLoginTextField()
        addPasswordUIView()
        addPasswordTextField()
        addEntryButton()
        entryButton.addTarget(self, action: #selector(auth), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc
    private func auth() {
        guard let login = loginTextField.text, let password = passwordTextField.text else { return }
        guard let viewModel = viewModel as? AuthViewModel else { return }
        let isSuccessChecked =  viewModel.checkAuthData(currentLogin: login,
                                                        currentPswd: password)
        viewModel.auth(isSuccessChecked: isSuccessChecked)
    }
    
    // MARK: Configure
    
    func configure(with viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func updateForKeyboardWillShowState(height: CGFloat) {
        contentInset.bottom = height
        verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
    }
    
    func updateForKeyboardWillHideState() {
        contentInset.bottom = .zero
        verticalScrollIndicatorInsets = .zero
    }
    
    // MARK: Add Subviews
    
    private func addContainerView() {
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    private func addLoginUIView() {
        containerView.addSubview(loginUIView)
        
        NSLayoutConstraint.activate([
            loginUIView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loginUIView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.offsetTop),
            loginUIView.heightAnchor.constraint(equalToConstant: Constants.height),
            loginUIView.widthAnchor.constraint(equalToConstant: Constants.width)
        ])
    }
    
    private func addLoginTextField() {
        loginUIView.addSubview(loginTextField)
        
        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: loginUIView.leadingAnchor, constant: Constants.insetLeading),
            loginTextField.centerYAnchor.constraint(equalTo: loginUIView.centerYAnchor)
        ])
    }
    
    private func addPasswordUIView() {
        containerView.addSubview(passwordUIView)
        
        NSLayoutConstraint.activate([
            passwordUIView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            passwordUIView.topAnchor.constraint(equalTo: loginUIView.bottomAnchor, constant: Constants.offsetBottom),
            passwordUIView.heightAnchor.constraint(equalToConstant: Constants.height),
            passwordUIView.widthAnchor.constraint(equalToConstant: Constants.width)
        ])
    }
    
    private func addPasswordTextField() {
        passwordUIView.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: passwordUIView.leadingAnchor, constant: Constants.insetLeading),
            passwordTextField.centerYAnchor.constraint(equalTo: passwordUIView.centerYAnchor)
        ])
    }
    
    private func addEntryButton() {
        containerView.addSubview(entryButton)
        
        NSLayoutConstraint.activate([
            entryButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            entryButton.topAnchor.constraint(equalTo: passwordUIView.bottomAnchor, constant: Constants.offsetBottom),
            entryButton.heightAnchor.constraint(equalToConstant: Constants.height),
            entryButton.widthAnchor.constraint(equalToConstant: Constants.width)
        ])
    }
}
