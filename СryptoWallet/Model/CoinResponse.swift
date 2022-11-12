//
//  Coin.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 07.11.2022.
//

import Foundation

struct Response: Codable {
    let data: CoinResponse
}

struct CoinResponse: Codable {
    let name: String
    var marketData: MarketData

    enum CodingKeys: String, CodingKey {
        case name
        case marketData = "market_data"
    }
}

struct MarketData: Codable {    
    let priceUSD: Double?
    let priceBTC: Double?
    let priceETH: Double?
    let percentChangeUSD1h: Double?
    var percentChangeUSD24h: Double?
    
    enum CodingKeys: String, CodingKey {
        case priceUSD = "price_usd"
        case priceBTC = "price_btc"
        case priceETH = "price_eth"
        case percentChangeUSD1h = "percent_change_usd_last_1_hour"
        case percentChangeUSD24h = "percent_change_usd_last_24_hours"
    }
}

struct Coin {
    let name: String
    let priceUSD: Double
    let priceBTC: Double
    let pricepriceETH: Double
    let percentChangeUSD24h: Double
}

extension Coin {
    
    func convertToCellModel() -> CoinTableViewCellModel {
        let cellModel = CoinTableViewCellModel(name: name, priceUSD: String(priceUSD), percentChangeUSD24h: String(percentChangeUSD24h))
        return cellModel
    }
}

extension CoinResponse {
    
    func createCellModel() -> CoinTableViewCellModel {
        let cellModel = CoinTableViewCellModel(name: name, priceUSD: nil, percentChangeUSD24h: nil)
        if let priceUSD = marketData.priceUSD {
            cellModel.priceUSD = String(priceUSD)
        }
        if let percentChangeUSD24h = marketData.percentChangeUSD24h {
            cellModel.percentChangeUSD24h = String(percentChangeUSD24h)
        }
        return cellModel
    }
    
    func convertToSort() -> Coin? {
        if let percentChangeUSD24h = marketData.percentChangeUSD24h,
           let priceUSD = marketData.priceUSD,
           let priceBTC = marketData.priceBTC,
           let priceETH = marketData.priceETH
        {
            return Coin(name: name,
                        priceUSD: priceUSD,
                        priceBTC: priceBTC,
                        pricepriceETH: priceETH,
                        percentChangeUSD24h: percentChangeUSD24h)
        } else {
            return nil
        }
    }
}
