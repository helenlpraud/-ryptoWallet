//
//  AuthViewController.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 02.11.2022.
//

import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: Initializers
    
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ViewModel
    
    var viewModel: AuthViewModelProtocol
    
    // MARK: Subviews
    
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
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.backgroundAuth
        addLoginUIView()
        addLoginTextField()
        addPasswordUIView()
        addPasswordTextField()
        addEntryButton()
        entryButton.addTarget(self, action: #selector(auth), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc
    private func auth() {
        guard let login = loginTextField.text, let password = passwordTextField.text else { return }
        let isSuccessChecked =  viewModel.checkAuthData(currentLogin: login,
                                                        currentPswd: password)
        guard let viewModel = viewModel as? AuthViewModel else { return }
        viewModel.auth(isSuccessChecked: isSuccessChecked)
    }
    
    // MARK: Add Subviews
    
    private func addLoginUIView() {
        view.addSubview(loginUIView)
        
        NSLayoutConstraint.activate([
            loginUIView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginUIView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.offsetTop),
            loginUIView.heightAnchor.constraint(equalToConstant: Constants.height),
            loginUIView.widthAnchor.constraint(equalToConstant: Constants.width)
        ])
    }
    
    private func addLoginTextField() {
        view.addSubview(loginTextField)
        
        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: loginUIView.leadingAnchor, constant: Constants.insetLeading),
            loginTextField.centerYAnchor.constraint(equalTo: loginUIView.centerYAnchor)
        ])
    }
    
    private func addPasswordUIView() {
        view.addSubview(passwordUIView)
        
        NSLayoutConstraint.activate([
            passwordUIView.centerXAnchor.constraint(equalTo: loginUIView.centerXAnchor),
            passwordUIView.topAnchor.constraint(equalTo: loginUIView.bottomAnchor, constant: Constants.offsetBottom),
            passwordUIView.heightAnchor.constraint(equalToConstant: Constants.height),
            passwordUIView.widthAnchor.constraint(equalToConstant: Constants.width)
        ])
    }
    
    private func addPasswordTextField() {
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: passwordUIView.leadingAnchor, constant: Constants.insetLeading),
            passwordTextField.centerYAnchor.constraint(equalTo: passwordUIView.centerYAnchor)
        ])
    }
    
    private func addEntryButton() {
        view.addSubview(entryButton)
        
        NSLayoutConstraint.activate([
            entryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            entryButton.topAnchor.constraint(equalTo: passwordUIView.bottomAnchor, constant: Constants.offsetBottom),
            entryButton.heightAnchor.constraint(equalToConstant: Constants.height),
            entryButton.widthAnchor.constraint(equalToConstant: Constants.width)
        ])
    }
}

// MARK: - Constants

private extension AuthViewController {
    
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
}
