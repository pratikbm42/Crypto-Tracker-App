//
//  CoinDetailDataService.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Combine
import Foundation

class CoinDetailDataService {
    @Published var coinDetail: CoinDetailModel? = nil

    var coinDetailSubscription: AnyCancellable?

    init(coin: CoinModel) {
        getCoinDetail(coinId: coin.id)
    }

    private func getCoinDetail(coinId: String) {
        let endpoint = "https://api.coingecko.com/api/v3/coins/\(coinId)"

        guard let url = URL(string: endpoint) else { return }

        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return
        }

        let queryItems = [
            URLQueryItem(name: "localization", value: "false"),
            URLQueryItem(name: "tickers", value: "false"),
            URLQueryItem(name: "market_data", value: "false"),
            URLQueryItem(name: "community_data", value: "false"),
            URLQueryItem(name: "developer_data", value: "false"),
            URLQueryItem(name: "sparkline", value: "false"),
        ]

        urlComponents.queryItems = queryItems

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "x-cg-demo-api-key": "CG-QoiUqdq6TLWiZKdnHGBZ8fCP", // TODO: Delete api key
        ]

        coinDetailSubscription =
            NetworkingManager.download(urlRequest: request)
                .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
                .sink(
                    receiveCompletion: NetworkingManager.handleCompletion,
                    receiveValue: { [weak self] returnedCoinDetail in
                        self?.coinDetail = returnedCoinDetail
                        self?.coinDetailSubscription?.cancel()
                    }
                )
    }
}
