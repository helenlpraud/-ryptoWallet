//
//  CoinsListViewModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 09.11.2022.
//

import Foundation
import UIKit

protocol CoinsListViewModelProtocol {
    
    var cellModels: [CoinTableViewCellModel] { get set }
    var didReloadTableView: (() -> Void)? { get set }
}

final class CoinsListViewModel: CoinsListViewModelProtocol {
    
    enum TypeSort {
        case fromLow
        case fromHigh
    }
    
    // MARK: Closures
    
    var didFetchSucces: (() -> Void)?
    var didFetchFail: ((String) -> Void)?
    var didReloadTableView: (() -> Void)?
    var didSelectCoin: ((Coin) -> Void)?
    var didSelectAction: ((UIAction) -> Void)?
    
    // MARK: Services
    
    let networkService: NetworkService
    
    // MARK: ViewModels
    
    var cellModels: [CoinTableViewCellModel] = []
    
    var headerModel: HeaderUIViewModel {
        let menu = UIMenuModel(title: "Start sort")
        let firstAction = UIActionModel(title: "From low change % to high") {_ in
            self.getSortedModels(typeSort: .fromLow)
        }
        let twoAction = UIActionModel(title: "From high change % to low") {_ in
            self.getSortedModels(typeSort: .fromHigh)
        }
        return HeaderUIViewModel(menuModel: menu, actionsModel: [firstAction, twoAction])
    }
    
    // MARK: Private Properties
    
    private var coinsResponses = [CoinResponse]()
    private var coins = [Coin]()
    private let requests: [CoinRequest]
    private let fetchGroup = DispatchGroup()
    
    // MARK: Initializer
    
    init(requests: [CoinRequest],
         networkService: NetworkService = NetworkService()) {
        self.requests = requests
        self.networkService = networkService
    }
    
    func getCellModel(for index: IndexPath) -> CoinTableViewCellModel {
        return cellModels[index.row]
    }
    
    func fetchCoins() {
        for request in requests {
            self.fetchCoin(request: request)
        }
        notify()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if coins.isEmpty { return }
        let coin = coins[indexPath.row]
        didSelectCoin?(coin)
//        let cellModel = cellModels[indexPath.row]
//        didSelectCoin?(cellModel)
//        let coinResponse = coinsResponses[indexPath.row]
//        didSelectCoin?(coinResponse)
    }
    
    // MARK: Private Functions
    
    private func fetchCoin(request: CoinRequest) {
        fetchGroup.enter()
        networkService.getCoin(with: request) { [weak self] result in
            switch result {
            case.failure(let error):
                DispatchQueue.main.async {
                    self?.didFetchFail?(error.reason)
                }
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    let cellModel = response.data.createCellModel()
                    self?.cellModels.append(cellModel)
                    self?.coinsResponses.append(response.data)
                    if let coin = response.data.convertToSort() {
                        self?.coins.append(coin)
                    }
                    self?.fetchGroup.leave()
                }
            }
        }
    }
    
    private func sortFromLow() {
        coins.sort {
            $0.percentChangeUSD24h < $1.percentChangeUSD24h
        }
    }
    
    private func sortFromHigh() {
        coins.sort {
            $0.percentChangeUSD24h > $1.percentChangeUSD24h
        }
    }
    
//    private func convertForSort() -> [Coin] {
//        let coins = coinsResponses
//        let coinsForSorted = coins.compactMap { coin in
//            coin.convertToSort()
//        }
//        return coinsForSorted
//    }
    
    private func getSortedModels(typeSort: TypeSort) {
        switch typeSort {
        case .fromLow:
            sortFromLow()
        case .fromHigh:
            sortFromHigh()
        }
        var sortedCellModels = [CoinTableViewCellModel]()
        for coin in coins {
            let cellModel = coin.convertToCellModel()
            sortedCellModels.append(cellModel)
        }
        cellModels = sortedCellModels
        didReloadTableView?()
    }
    
    private func notify() {
        fetchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            self?.didFetchSucces?()
        }
    }
}
