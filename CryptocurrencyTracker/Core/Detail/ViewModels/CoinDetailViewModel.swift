//
//  CoinDetailViewModel.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Combine
import Foundation

class CoinDetailViewModel: ObservableObject {
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var aditionalStatistics: [StatisticModel] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var subredditURL: String? = nil

    private let coinDetailDataService: CoinDetailDataService

    private var cancellables = Set<AnyCancellable>()

    let coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }

    private func addSubscribers() {
        self.coinDetailDataService.$coinDetail
            .map(self.mapDataToStatistics)
            .sink(receiveValue: { [weak self] returnedOverviewStats, returnedAditionalStats in
                self?.overviewStatistics = returnedOverviewStats
                self?.aditionalStatistics = returnedAditionalStats
            })
            .store(in: &self.cancellables)

        self.coinDetailDataService.$coinDetail
            .sink { [weak self] coinDetailModel in
                self?.coinDescription = coinDetailModel?.readableDescription
                self?.websiteURL = coinDetailModel?.links?.homepage?.first
                self?.subredditURL = coinDetailModel?.links?.subredditURL
            }
            .store(in: &self.cancellables)
    }

    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?) -> (overview: [StatisticModel], aditional: [StatisticModel]) {

        let price = self.coin.currentPrice.asCurrencyWithDecimals()
        let pricePercent = self.coin.priceChangePercentage24h
        let priceStat = StatisticModel(title: "Current Price", value: price, precentageChange: pricePercent)

        let marketCap = "$" + ((self.coin.marketCap?.formattedWithAbbreviations()) ?? "")
        let marketCapPercent = self.coin.marketCapChangePercentage24h
        let marketCapStat = StatisticModel(title: "Market Cap.", value: marketCap, precentageChange: marketCapPercent)

        let rank = String(self.coin.rank)
        let rankStat = StatisticModel(title: "Rank", value: rank)

        let volume = "$" + (self.coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)

        let overviewStats = [priceStat, marketCapStat, rankStat, volumeStat]

        let height = self.coin.high24h?.asCurrencyWithDecimals() ?? ""
        let heightStat = StatisticModel(title: "24h Height", value: height)

        let low = self.coin.low24h?.asCurrencyWithDecimals() ?? ""
        let lowStat = StatisticModel(title: "24h Low", value: low)

        let priceChange = self.coin.priceChange24h?.asCurrencyWithDecimals() ?? ""
        let priceChangePercent = self.coin.priceChangePercentage24h
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, precentageChange: priceChangePercent)

        let marketCapChange = "$" + ((self.coin.marketCapChange24h?.formattedWithAbbreviations()) ?? "")
        let marketCapChangePercent = self.coin.marketCapChangePercentage24h
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap. Change", value: marketCapChange, precentageChange: marketCapChangePercent)

        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : String(blockTime)
        let blocTimeStat = StatisticModel(title: "Block Time", value: blockTimeString)

        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)

        let aditionalStats = [heightStat, lowStat, priceChangeStat, marketCapChangeStat, blocTimeStat, hashingStat]

        return (overviewStats, aditionalStats)
    }
}
