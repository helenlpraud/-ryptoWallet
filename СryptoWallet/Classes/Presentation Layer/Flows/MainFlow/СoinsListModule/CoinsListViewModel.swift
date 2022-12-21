//
//  CoinsListViewModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 09.11.2022.
//

import Foundation

protocol CoinsListViewModelProtocol {
    
    var cellModels: [CoinTableViewCellModel] { get set }
    var headerModel: HeaderUIViewModel? { get }
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
    
    // MARK: Closures
    
    var didFetchSucces: (() -> Void)?
    var didFetchFail: ((String) -> Void)?
    var didReloadTableView: (() -> Void)?
    var didSelectCoin: ((CoinTableViewCellModel) -> Void)?
    
    // MARK: Services
    
    var networkService: NetworkServiceProtocol
    var authService: AuthService?
    
    // MARK: ViewModels
    
    var cellModels: [CoinTableViewCellModel] = []
    
    var headerModel: HeaderUIViewModel?
    
    // MARK: Public Properties
    
    var heightForRow: CGFloat = 130.0
    
    private enum TypeSort {
        case fromLow
        case fromHigh
    }
    
    // MARK: Private Properties
    
    private let requests: [CoinRequest]
    private let fetchGroup = DispatchGroup()
    
    private var coinsForSorting = [Coin]()
    private var coinsNotForSorting = [CoinTableViewCellModel]()
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
        
        setHeaderModel()
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
    
    private func setHeaderModel() {
        let menu = UIMenuModel(title: StringsHeader.menuModel)
        let firstAction = UIActionModel(title: StringsHeader.actionLowToHigh) { [weak self] _ in
            self?.getSortedModels(typeSort: .fromLow)
            self?.changeStateHeader(stateHeader: .sortFromLow)
        }
        let twoAction = UIActionModel(title: StringsHeader.actionHighToLow) { [weak self] _ in
            self?.getSortedModels(typeSort: .fromHigh)
            self?.changeStateHeader(stateHeader: .sortFromHigh)
        }
        headerModel = HeaderUIViewModel(menuModel: menu, actionsModel: [firstAction, twoAction])
    }
    
    private func fetchCoin(request: CoinRequest) {
        fetchGroup.enter()
        networkService.getCoin(with: request) { [weak self] result in
            switch result {
            case.failure(let error):
                self?.resultsRequests.append(false)
                    self?.didFetchFail?(error.reason)
                    self?.fetchGroup.leave()
            case .success(let response):
                self?.resultsRequests.append(true)
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
    
    private func changeStateHeader(stateHeader: StateHeader) {
        headerModel?.changeStateHeader(stateHeader: stateHeader)
    }
}
