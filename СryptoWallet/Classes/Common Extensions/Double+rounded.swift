//
//  Double+rounded.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 20.11.2022.
//

import Foundation

extension Double {
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
