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
    var headerModel: HeaderUIViewModel { get }
    var heightForRow: CGFloat { get set }
    
    var didReloadTableView: (() -> Void)? { get set }
    var didFetchSucces: (() -> Void)? { get set }
    var didFetchFail: ((String) -> Void)? { get set }
    var didSelectCoin: ((CoinTableViewCellModel) -> Void)? { get set }
    
    func fetchCoins()
    func didSelectRow(at indexPath: IndexPath)
    func getCellModel(for index: IndexPath) -> CoinTableViewCellModel
    func logout()
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
    var didSelectCoin: ((CoinTableViewCellModel) -> Void)?
    var didSelectAction: ((UIAction) -> Void)?
    
    // MARK: Services
    
    var networkService: NetworkServiceProtocol
    var authService: AuthService?
    
    // MARK: ViewModels
    
    var cellModels: [CoinTableViewCellModel] = []
    
    var headerModel: HeaderUIViewModel {
        let menu = UIMenuModel(title: StringsHeader.menuModel)
        let firstAction = UIActionModel(title: StringsHeader.actionLowToHigh) { [weak self] _ in
            self?.getSortedModels(typeSort: .fromLow)
        }
        let twoAction = UIActionModel(title: StringsHeader.actionHighToLow) { [weak self] _ in
            self?.getSortedModels(typeSort: .fromHigh)
        }
        return HeaderUIViewModel(menuModel: menu, actionsModel: [firstAction, twoAction])
    }
    
    var heightForRow: CGFloat = 130.0
    
    // MARK: Private Properties
    
    private var coinsForSorting = [Coin]()
    private var coinsNotForSorting = [CoinTableViewCellModel]()
    
    private let requests: [CoinRequest]
    private let fetchGroup = DispatchGroup()
    
    private var resultsRequests = [Bool]()
    private var isSuccess: Bool {
        if resultsRequests.contains(false) {
            return false
        } else {
            return true
        }
    }
    
    // MARK: Initializer
    
    init(requests: [CoinRequest],
         networkService: NetworkServiceProtocol) {
        self.requests = requests
        self.networkService = networkService
    }
    
    // MARK: Public Functions
    
    func getCellModel(for index: IndexPath) -> CoinTableViewCellModel {
        return cellModels[index.row]
    }
    
    func fetchCoins() {
        resultsRequests = []
        for request in requests {
            self.fetchCoin(request: request)
        }
        notify()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if cellModels.isEmpty { return }
        let coinModel = cellModels[indexPath.row]
        didSelectCoin?(coinModel)
    }
    
    func logout() {
        authService?.logout()
    }
    
    // MARK: Private Functions
    
    private func fetchCoin(request: CoinRequest) {
        fetchGroup.enter()
        networkService.getCoin(with: request) { [weak self] result in
            switch result {
            case.failure(let error):
                self?.resultsRequests.append(false)
                DispatchQueue.main.async {
                    self?.didFetchFail?(error.reason)
                    self?.fetchGroup.leave()
                }
            case .success(let response):
                self?.resultsRequests.append(true)
                DispatchQueue.main.async { [weak self] in
                    let cellModel = response.data.createCellModel()
                    self?.cellModels.append(cellModel)
                    if let coin = response.data.convertToCoin() {
                        self?.coinsForSorting.append(coin)
                    } else {
                        self?.coinsNotForSorting.append(cellModel)
                    }
                    self?.fetchGroup.leave()
                }
            }
        }
    }
    
    private func sortFromLow() {
        coinsForSorting.sort {
            $0.percentChangeUSD24h < $1.percentChangeUSD24h
        }
    }
    
    private func sortFromHigh() {
        coinsForSorting.sort {
            $0.percentChangeUSD24h > $1.percentChangeUSD24h
        }
    }
    
    private func getSortedModels(typeSort: TypeSort) {
        switch typeSort {
        case .fromLow:
            sortFromLow()
        case .fromHigh:
            sortFromHigh()
        }
        var sortedCellModels = [CoinTableViewCellModel]()
        for coin in coinsForSorting {
            let cellModel = coin.convertToCellModel()
            sortedCellModels.append(cellModel)
        }
        cellModels = sortedCellModels + coinsNotForSorting
        didReloadTableView?()
    }
    
    private func notify() {
        fetchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            if self?.isSuccess == true {
                self?.didFetchSucces?()
            }
        }
    }
}
