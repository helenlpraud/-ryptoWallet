//
//  StringsNetwork.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 14.11.2022.
//

enum StringsNetwork {
    
    static var url: String {
        return "https://data.messari.io/api/v1"
    }
    
    static var errorFetching: String {
        return "An error occurred while fetching data"
    }
    
    static var errorDecoding: String {
        return "An error occurred while decoding data"
    }
}
