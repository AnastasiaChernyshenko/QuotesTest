//
//  Quote.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation

struct Quote: Codable {
    var symbol: String?
    var name: String?
    var currency: String?
    var readableLastChangePercent: String?
    var last: String?
    var variationColor: VariationColor?
}

class QuoteFavourite {
    let quote: Quote?
    var isFavourite: Bool
    
    init(quote: Quote?, isFavourite: Bool) {
        self.quote = quote
        self.isFavourite = isFavourite
    }
}

enum VariationColor: String, Codable {
    case red
    case green
}
