//
//  DataResponseError.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 09.11.2022.
//

import Foundation

enum DataResponseError: Error {
  case network
  case decoding
  
  var reason: String {
    switch self {
    case .network:
        return StringsNetwork.errorFetching
    case .decoding:
        return StringsNetwork.errorDecoding
    }
  }
}
