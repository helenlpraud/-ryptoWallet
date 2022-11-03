//
//  AuthViewController.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 02.11.2022.
//

import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: - Subviews
    
    private let loginUIView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderColor = Colors.borderAuth
        view.layer.borderWidth = 2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let passwordUIView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderColor = Colors.borderAuth
        view.layer.borderWidth = 2
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
        button.layer.cornerRadius = 5
        button.layer.borderColor = Colors.buttonBorderColorAuth
        button.layer.borderWidth = 2
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.backgroundAuth
        addLoginUIView()
        addLoginTextField()
        addPasswordUIView()
        addPasswordTextField()
        addEntryButton()
    }
    
    // MARK: - Private Functions
    
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
            loginTextField.centerXAnchor.constraint(equalTo: loginUIView.centerXAnchor),
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
            passwordTextField.centerXAnchor.constraint(equalTo: passwordUIView.centerXAnchor),
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
    }
}
