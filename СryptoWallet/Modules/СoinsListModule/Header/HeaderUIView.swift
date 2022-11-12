//
//  HeaderUIView.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 10.11.2022.
//

import UIKit

final class HeaderUIView: UITableViewHeaderFooterView {
    
    //MARK: ViewModel
    
    var viewModel: HeaderUIViewModel?
    
    // MARK: Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSortButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .black
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func addSortButton() {
        addSubview(sortButton)
        
        NSLayoutConstraint.activate([
            sortButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            sortButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            sortButton.heightAnchor.constraint(equalToConstant: 50),
            sortButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }

    func configure(with model: HeaderUIViewModel) {
        self.viewModel = model
        var menuItems = [UIAction]()
        for item in model.actionsModel {
            let title = item.title
            let handler = item.didSelectAction
            guard let handler = handler else { return }
            let action = UIAction(title: title, handler: handler)
            menuItems.append(action)
        }
        let menu = UIMenu(title: model.menuModel.title, image: nil, identifier: nil, options: .displayInline, children: menuItems)
        sortButton.menu = menu
    }
}
