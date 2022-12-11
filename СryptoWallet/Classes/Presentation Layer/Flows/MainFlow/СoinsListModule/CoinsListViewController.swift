//
//  CoinsListViewController.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 07.11.2022.
//

import UIKit

protocol CoinsListModule: Presentable {
    
    // MARK: Public Properties
    
    var onCoinSelect: ((CoinTableViewCellModel) -> ())? { get set }
    var onLogout: (() -> Void)? { get set }
}

final class CoinsListViewController: UIViewController,
                                     CoinsListModule {
    
    enum Constants {
        
        static var reloadButtonSize: Double {
            return 50.0
        }
        
        static var inset: Double {
            return -20.0
        }
        
        static var headerHeight: Double {
            return 100.0
        }
        
        static var cornerRadius: Double {
            return 5.0
        }
        
        static var borderWidth: Double {
            return 2.0
        }
    }
    
    // MARK: Public Properties
    
    var onCoinSelect: ((CoinTableViewCellModel) -> ())?
    var onLogout: (() -> Void)?
    
    // MARK: ViewModel
    
    var viewModel: CoinsListViewModelProtocol?
    
    // MARK: Subviews
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.color = .blue
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reloadButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.borderWidth = Constants.borderWidth
        button.layer.borderColor = Colors.borderAuth
        button.setImage(Images.reloadImage, for: .normal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.reuseIdentifier)
        tableView.register(HeaderUIView.self, forHeaderFooterViewReuseIdentifier: "Header")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var headerView = HeaderUIView()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        reloadButton.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        
        setNavigationItem()
        addSubviews()
        bindViewModel()
//        viewModel?.start()
        viewModel?.fetchCoins()
    }
    
    // MARK: Actions
    
    @objc
    private func logout() {
        viewModel?.logout()
        onLogout?()
    }
    
    @objc
    private func reloadData() {
        viewModel?.fetchCoins()
    }
    
    private func setNavigationItem() {
        let buttonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logout)
        )
        buttonItem.tintColor = Colors.placeholderAuth
        navigationItem.leftBarButtonItem = buttonItem
    }
    
    private func addSubviews() {
        addIndicatorView()
        addReloadButton()
        addErrorLabel()
        addTableView()
    }
    
    // MARK: Add Subviews
    
    private func addIndicatorView() {
        view.addSubview(indicatorView)
        indicatorView.startAnimating()
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func addReloadButton() {
        view.addSubview(reloadButton)
        
        NSLayoutConstraint.activate([
            reloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            reloadButton.heightAnchor.constraint(equalToConstant: Constants.reloadButtonSize),
            reloadButton.widthAnchor.constraint(equalToConstant: Constants.reloadButtonSize)
        ])
    }
    
    private func addErrorLabel() {
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: reloadButton.centerXAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: reloadButton.topAnchor, constant: Constants.inset)
        ])
    }
    
    private func addTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        if let headerVM = viewModel?.headerModel {
            headerView.configure(with: headerVM)
        }
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.maxX, height: Constants.headerHeight)
        tableView.tableHeaderView = headerView
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // MARK: Binding Model
    
    private func bindViewModel() {
        viewModel?.didFetchFail = { [weak self] reason in
            self?.indicatorView.stopAnimating()
            self?.errorLabel.text = reason
            self?.errorLabel.isHidden = false
            self?.reloadButton.isHidden = false
        }
        
        viewModel?.didFetchSucces = { [weak self] in
            self?.indicatorView.stopAnimating()
            self?.errorLabel.isHidden = true
            self?.reloadButton.isHidden = true
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
        }
        
        viewModel?.didReloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel?.didSelectCoin = { [weak self] coin in
            self?.onCoinSelect?(coin)
        }
        
        viewModel?.headerModel?.didChangeStateHeader = { [weak self] state in
            self?.headerView.changeState(stateHeader: state)
        }
    }
}

// MARK: - UITableViewDataSource

extension CoinsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.cellModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reuseIdentifier, for: indexPath) as? CoinTableViewCell else {
            preconditionFailure("Invalid cell")
        }
        if let cellVM = viewModel?.getCellModel(for: indexPath) {
            cell.configure(with: cellVM)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CoinsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightForRow ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRow(at: indexPath)
    }
}
