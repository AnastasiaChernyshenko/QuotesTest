//
//  QuotesViewModel.swift
//  Technical-test
//
//  Created by mac on 28.03.2023.
//

import Foundation
import Combine

final class QuotesViewModel: NSObject {
    
    @Published var quoteFavourite: [QuoteFavourite] = []
    
    private let dataManager: DataManager = DataManager()
    
    private var quotes: [Quote] = [] {
        didSet {
            updateFavouriteQuotes()
        }
    }
    
    func getQuotes() {
        Task { quotes = try await dataManager.fetchQuotes() }
    }
    
    func updateFavouriteQuotes() {
        quoteFavourite = quotes.map { quote in
            let favouriteNames = UserDefaults.standard.favouriteQuoteNames
            return QuoteFavourite(quote: quote, isFavourite: favouriteNames.contains(quote.name ?? ""))
        }
    }
}

