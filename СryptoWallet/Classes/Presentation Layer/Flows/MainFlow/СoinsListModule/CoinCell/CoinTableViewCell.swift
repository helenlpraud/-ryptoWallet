//
//  CoinTableViewCell.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 07.11.2022.
//

import UIKit

final class CoinTableViewCell: UITableViewCell,
                               Configurable {
    
    // MARK: ViewModel
    
    typealias ViewModel = CoinTableViewCellModelProtocol
    
    // MARK: Subviews
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceUSDLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let percentChangeUSD24hLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        nameLabel.text = ""
        priceUSDLabel.text = ""
        percentChangeUSD24hLabel.text = ""
    }
    
    // MARK: Initializers

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addNameLabel()
        addPriceUSDLabel()
        addPercentChangeUSD24hLabel()
    }
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addNameLabel()
        addPriceUSDLabel()
        addPercentChangeUSD24hLabel()
    }
    
    // MARK: Configure
    
    func configure(with model: ViewModel) {
        nameLabel.text = "Coin: " + model.name
        if let priceUSD = model.priceUSD {
            priceUSDLabel.text = "Price, $: " + priceUSD
        }
        if let percentChangeUSD24h = model.percentChangeUSD24h {
            percentChangeUSD24hLabel.text = "% change USD 24h: " + percentChangeUSD24h
        }
        
        backgroundColor = .white
        selectionStyle = .none
    }
    
    // MARK: Add Subviews
    
    private func addNameLabel() {
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.insetLeading),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.offsetTop)
        ])
    }
    
    private func addPriceUSDLabel() {
        contentView.addSubview(priceUSDLabel)
        
        NSLayoutConstraint.activate([
            priceUSDLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceUSDLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.offsetBottom)
        ])
    }
    
    private func addPercentChangeUSD24hLabel() {
        contentView.addSubview(percentChangeUSD24hLabel)
        
        NSLayoutConstraint.activate([
            percentChangeUSD24hLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            percentChangeUSD24hLabel.topAnchor.constraint(equalTo: priceUSDLabel.bottomAnchor, constant: Constants.offsetBottom)
        ])
    }
}

// MARK: - Constants

private extension CoinTableViewCell {
    
    enum Constants {
        
        static var offsetTop: Double {
            return 16.0
        }
        
        static var insetLeading: Double {
            return 16.0
        }
        
        static var offsetBottom: Double {
            return 20.0
        }
    }
}
