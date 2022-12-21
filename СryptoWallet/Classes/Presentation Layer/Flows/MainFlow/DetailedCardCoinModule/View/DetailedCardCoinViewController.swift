//
//  DetailedCardCoinViewController.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 07.11.2022.
//

import UIKit

final class DetailedCardCoinViewController: UIViewController {
    
    // MARK: ViewModel
    
    var viewModel: DetailedCardCoinViewModelProtocol?
    
    // MARK: Subviews
    
    private let detailCardview: DetailCardCoinView = {
        let view = DetailCardCoinView()
        return view
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel as? DetailedCardCoinViewModel else { return }
        addDetailCardView()
        detailCardview.configure(with: viewModel)
    }
    
    // MARK: Add Subviews
    
    private func addDetailCardView() {
        view.addSubview(detailCardview)
        detailCardview.frame = view.frame
    }
}
