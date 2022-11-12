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
      return "An error occurred while fetching data "
    case .decoding:
      return "An error occurred while decoding data"
    }
  }
}
