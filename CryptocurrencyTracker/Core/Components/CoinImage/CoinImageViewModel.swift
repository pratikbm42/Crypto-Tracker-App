//
//  CoinImageViewModel.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Combine
import Foundation
import SwiftUI

class CoinImageViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var image: UIImage? = nil

    private let coin: CoinModel
    private let coinImageService: CoinImageService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.coin = coin
        self.isLoading = true
        self.coinImageService = CoinImageService(coin: coin)
        addSubscribers()
    }

    private func addSubscribers() {
        coinImageService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
