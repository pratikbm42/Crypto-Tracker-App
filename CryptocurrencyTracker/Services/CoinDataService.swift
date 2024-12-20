//
//  CoinDataService.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Combine
import Foundation

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?

    init() {
        getCoins()
    }

    func getCoins() {
        let endpoint = "https://api.coingecko.com/api/v3/coins/markets"

        guard let url = URL(string: endpoint) else { return }

        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return
        }

        let queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "per_page", value: "250"),
            URLQueryItem(name: "sparkline", value: "true"),
            URLQueryItem(name: "price_change_percentage", value: "24h")
        ]

        urlComponents.queryItems = queryItems

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "x-cg-demo-api-key": "CG-QoiUqdq6TLWiZKdnHGBZ8fCP"
        ]

        coinSubscription =
            NetworkingManager.download(urlRequest: request)
                .decode(type: [CoinModel].self, decoder: JSONDecoder())
                .sink(
                    receiveCompletion: NetworkingManager.handleCompletion,
                    receiveValue: { [weak self] returnedCoins in
                        self?.allCoins = returnedCoins
                        self?.coinSubscription?.cancel()
                    }
                )
    }
}
