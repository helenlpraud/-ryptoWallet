//
//  CoinsListViewController.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 07.11.2022.
//

import UIKit

final class CoinsListViewController: UIViewController {
    
    // MARK: ViewModel
    
    let viewModel: CoinsListViewModel
    
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
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 2.0
        button.layer.borderColor = Colors.borderAuth
        button.setImage(UIImage(systemName: "repeat"), for: .normal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.registerCellClass(CoinTableViewCell.self)
        tableView.register(HeaderUIView.self, forHeaderFooterViewReuseIdentifier: "Header")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Initialaizers
    
    init(with viewModel: CoinsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addIndicatorView()
        addReloadButton()
        addErrorLabel()
        addTableView()
        
        bindViewModel()
        viewModel.fetchCoins()
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
            reloadButton.heightAnchor.constraint(equalToConstant: 50.0),
            reloadButton.widthAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func addErrorLabel() {
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: reloadButton.centerXAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: reloadButton.topAnchor, constant: -20.0)
        ])
    }
    
    private func addTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let headerView = HeaderUIView()
        let headerVM = viewModel.headerModel
        headerView.configure(with: headerVM)
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.maxX, height: 100)
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
        viewModel.didFetchFail = { [weak self] reason in
            DispatchQueue.main.async {
                self?.indicatorView.stopAnimating()
                self?.errorLabel.text = reason
                self?.errorLabel.isHidden = false
                self?.reloadButton.isHidden = false
            }
        }
        
        viewModel.didFetchSucces = { [weak self] in
            DispatchQueue.main.async {
                self?.indicatorView.stopAnimating()
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }
        }
        
        viewModel.didReloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.didSelectCoin = { [weak self] coin in
            let viewModel = DetailedCardCoinViewModel(coin: coin)
            let vc = DetailedCardCoinViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource

extension CoinsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String.className(CoinTableViewCell.self), for: indexPath) as? CoinTableViewCell  else {
            preconditionFailure("Invalid cell")
        }
        cell.backgroundColor = .white
        let cellVM = viewModel.getCellModel(for: indexPath)
        cell.configure(with: cellVM)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CoinsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}
