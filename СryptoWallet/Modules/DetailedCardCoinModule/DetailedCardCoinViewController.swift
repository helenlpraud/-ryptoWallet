//
//  DetailedCardCoinViewController.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 07.11.2022.
//

import UIKit

class DetailedCardCoinViewController: UIViewController {
    
    // MARK: - Subviews
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Coin: "
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceUSDLabel: UILabel = {
        let label = UILabel()
        label.text = "Price, $: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let percentChangeUSD24hLabel: UILabel = {
        let label = UILabel()
        label.text = "Percent change USD 24h: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addNameLabel()
        addPriceUSDLabel()
        addPercentChangeUSD24hLabel()
    }
    
    // MARK: - Add Subviews
    
    private func addNameLabel() {
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.insetLeading),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.offsetTop)
        ])
    }
    
    private func addPriceUSDLabel() {
        view.addSubview(priceUSDLabel)
        
        NSLayoutConstraint.activate([
            priceUSDLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceUSDLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.offsetBottom)
        ])
    }
    
    private func addPercentChangeUSD24hLabel() {
        view.addSubview(percentChangeUSD24hLabel)
        
        NSLayoutConstraint.activate([
            percentChangeUSD24hLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            percentChangeUSD24hLabel.topAnchor.constraint(equalTo: priceUSDLabel.bottomAnchor, constant: Constants.offsetBottom)
        ])
    }
}

// MARK: - Constants

private extension DetailedCardCoinViewController {
    
    enum Constants {
        
        static var offsetTop: Double {
            return 250.0
        }
        
        static var insetLeading: Double {
            return 16.0
        }
        
        static var offsetBottom: Double {
            return 20.0
        }
    }
}
