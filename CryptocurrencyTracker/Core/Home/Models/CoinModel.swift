//
//  CoinModel.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Foundation

// CoinGecko Api Info
/*
 URL:

 JSON Response:
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 69442,
     "market_cap": 1368226308606,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 1457800144281,
     "total_volume": 12223720486,
     "high_24h": 69544,
     "low_24h": 68972,
     "price_change_24h": 148.45,
     "price_change_percentage_24h": 0.21423,
     "market_cap_change_24h": 2080004148,
     "market_cap_change_percentage_24h": 0.15225,
     "circulating_supply": 19709665,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 73738,
     "ath_change_percentage": -5.85707,
     "ath_date": "2024-03-14T07:10:36.635Z",
     "atl": 67.81,
     "atl_change_percentage": 102274.39645,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2024-06-08T19:47:10.594Z",
     "sparkline_in_7d": {
       "price": [
         67715.54978593417,
         67707.46184486896,
         69361.46134430173
       ]
     },
     "price_change_percentage_24h_in_currency": 0.2142348571947852
   }
 */

import Foundation

struct CoinModel: Identifiable, Codable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap: Double?
    let marketCapRank: Double?
    let fullyDilutedValuation: Double?
    let totalVolume: Double?
    let high24h: Double?
    let low24h: Double?
    let priceChange24h: Double?
    let priceChangePercentage24h: Double?
    let marketCapChange24h: Double?
    let marketCapChangePercentage24h: Double?
    let circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    let ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl: Double?
    let atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24hInCurrency: Double?
    let currentHoldings: Double?

    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }

    var rank: Int {
        return Int(marketCapRank ?? 0)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24hInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }

    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice,
            marketCap: marketCap,
            marketCapRank: marketCapRank,
            fullyDilutedValuation: fullyDilutedValuation,
            totalVolume: totalVolume,
            high24h: high24h,
            low24h: low24h,
            priceChange24h: priceChange24h,
            priceChangePercentage24h: priceChangePercentage24h,
            marketCapChange24h: marketCapChange24h,
            marketCapChangePercentage24h: marketCapChangePercentage24h,
            circulatingSupply: circulatingSupply,
            totalSupply: totalSupply,
            maxSupply: maxSupply,
            ath: ath,
            athChangePercentage: athChangePercentage,
            athDate: athDate,
            atl: atl,
            atlChangePercentage: atlChangePercentage,
            atlDate: atlDate,
            lastUpdated: lastUpdated,
            sparklineIn7D: sparklineIn7D,
            priceChangePercentage24hInCurrency: priceChangePercentage24hInCurrency,
            currentHoldings: amount
        )
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
