//
//  CoinImageService.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Combine
import Foundation
import SwiftUI

class CoinImageService {
    @Published var image: UIImage? = nil
    private var subscription: AnyCancellable?
    private var coin: CoinModel
    private let localFileManager = LocalFileManager.instance
    private let imageName: String
    private let folderName: String = "coin_images"

    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }

    private func getCoinImage() {
        if let savedImage = localFileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            fetchCoinImage(coin: coin)
        }
    }

    private func fetchCoinImage(coin: CoinModel) {
        guard let url = URL(string: coin.image) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        subscription = NetworkingManager.download(urlRequest: request)
            .tryMap { data -> UIImage? in
                UIImage(data: data)
            }
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] returnedImage in
                    guard let self = self, let dowloadedImage = returnedImage else { return }
                    self.image = returnedImage
                    self.subscription?.cancel()
                    self.localFileManager.saveImage(image: dowloadedImage, imageName: self.imageName, folderName: self.folderName)
                }
            )
    }
}
