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
    let marketData: MarketData

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
    let percentChangeUSD24h: Double?
    
    enum CodingKeys: String, CodingKey {
        case priceUSD = "price_usd"
        case priceBTC = "price_btc"
        case priceETH = "price_eth"
        case percentChangeUSD1h = "percent_change_usd_last_1_hour"
        case percentChangeUSD24h = "percent_change_usd_last_24_hours"
    }
}
