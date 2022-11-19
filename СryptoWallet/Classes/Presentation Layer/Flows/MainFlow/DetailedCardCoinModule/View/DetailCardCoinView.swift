//
//  DetailCardCoinView.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 15.11.2022.
//

import UIKit

class DetailCardCoinView: UIView {
    
    enum Constants {
        
        static var offsetTop: Double {
            return 16.0
        }
        
        static var insetLeading: Double {
            return 16.0
        }
        
        static var insetTrailing: Double {
            return -16.0
        }
        
        static var offsetBottom: Double {
            return 20.0
        }
    }
    
    private let container: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceUSDLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private let percentChangeUSD24hLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        backgroundColor = .white
        addContainer()
        container.addArrangedSubview(nameLabel)
        container.addArrangedSubview(priceUSDLabel)
        container.addArrangedSubview(percentChangeUSD24hLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContainer() {
        addSubview(container)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: Constants.insetLeading),
            container.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: Constants.insetTrailing),
            container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                           constant: Constants.offsetTop),
            container.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configure(with model: DetailedCardCoinViewModel) {
        nameLabel.text = "Coin: " + model.name
        if let priceUSD = model.priceUSD {
            priceUSDLabel.isHidden = false
            priceUSDLabel.text = "Price, $: " + priceUSD
        } else {
            priceUSDLabel.isHidden = true
        }
        if let percentChangeUSD24h = model.percentChangeUSD24h {
            percentChangeUSD24hLabel.isHidden = false
            percentChangeUSD24hLabel.text = "% change USD 24h: " + percentChangeUSD24h
        } else {
            percentChangeUSD24hLabel.isHidden = true
        }
    }
}
