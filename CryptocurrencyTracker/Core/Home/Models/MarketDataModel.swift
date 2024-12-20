//
//  MarketDataModel.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Foundation

// JSON response
/*
  URL: https://api.coingecko.com/api/v3/global

 JSON:
 {
   "data": {
     "active_cryptocurrencies": 14775,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1129,
     "total_market_cap": {
       "btc": 38484371.54778412,
       "eth": 713899946.7611843,
       "ltc": 31893864062.398113,
       "bch": 5905493937.897693,
       "bnb": 4205253764.0496607,
       "eos": 3858565239886.524,
       "xrp": 5203894270360.658,
       "xlm": 25943397964148.977,
       "link": 172979619422.00018,
       "dot": 409951204857.8082,
       "yfi": 404154173.9811488,
       "usd": 2542764307774.28,
        ...
     },
     "market_cap_percentage": {
       "btc": 51.2225618015415,
       "eth": 16.836933638189677,
       "usdt": 4.420773193799218,
       "bnb": 3.6607700044450833,
       "sol": 2.6196688162014428,
       "steth": 1.3348569372726868,
       "usdc": 1.2751915852261577,
       "xrp": 1.0677625819860523,
       "doge": 0.7723196959336398,
       "ton": 0.750414263817647
     },
     "market_cap_change_percentage_24h_usd": 0.6470171248681403,
     "updated_at": 1718506332
   }
 }
  */

struct GlobalMarketData: Codable {
    let data: MarketDataModel
}

struct MarketDataModel: Codable {
    let totalMarketCap: [String: Double]
    let totalVolume: [String: Double]
    let marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }

    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }

    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }

    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPercentString()
        }
        return ""
    }
}
