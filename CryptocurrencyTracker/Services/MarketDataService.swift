//
//  MarketDataService.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Combine
import Foundation

class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?

    init() {
        getMarketData()
    }

    func getMarketData() {
        let endpoint = "https://api.coingecko.com/api/v3/global"

        guard let url = URL(string: endpoint) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "x-cg-demo-api-key": "CG-QoiUqdq6TLWiZKdnHGBZ8fCP"
        ]

        marketDataSubscription =
            NetworkingManager.download(urlRequest: request)
                .decode(type: GlobalMarketData.self, decoder: JSONDecoder())
                .sink(
                    receiveCompletion: NetworkingManager.handleCompletion,
                    receiveValue: { [weak self] returnedGlobalMarkedData in
                        self?.marketData = returnedGlobalMarkedData.data
                        self?.marketDataSubscription?.cancel()
                    }
                )
    }
}
