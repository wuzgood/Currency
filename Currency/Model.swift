//
//  Model.swift
//  Currency
//
//  Created by Wuz Good on 27.10.2021.
//

import Foundation

typealias NBU = [NationalBank]

struct NationalBank: Codable {
    let r030: Int
    let txt: String
    let rate: Double
    let cc: String
    let exchangedate: String
}

typealias PB = [PrivatBank]

struct PrivatBank: Codable {
    let ccy: String
    let base_ccy: String
    let buy: String
    let sale: String
}



