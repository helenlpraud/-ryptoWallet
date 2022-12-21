//
//  HTTPURLResponse + hasSucsessStatusCode.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 09.11.2022.
//

import Foundation

extension HTTPURLResponse {
    
  var hasSuccessStatusCode: Bool {
    return 200...299 ~= statusCode
  }
}
